module 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist {
    struct Mist has store, key {
        id: 0x2::object::UID,
        tick: 0x1::string::String,
        utxo: 0x2::coin::Coin<0x2::sui::SUI>,
        balance: u64,
        content_type: 0x1::string::String,
    }

    struct InscriptionHouse has key {
        id: 0x2::object::UID,
        inscription_info: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        inscriptions: 0x2::table_vec::TableVec<0x1::string::String>,
    }

    struct MistHouse has key {
        id: 0x2::object::UID,
        tick: 0x1::string::String,
        lim: u64,
        circulating_supply: u64,
        total_supply: u64,
        claim_queue: 0x2::priority_queue::PriorityQueue<address>,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
        account_map: 0x2::vec_map::VecMap<address, u64>,
        mist_round_message: u64,
        need_rand: bool,
        maximum_one_account: u64,
        round: u64,
    }

    struct MIST has drop {
        dummy_field: bool,
    }

    public entry fun claim(arg0: &mut MistHouse, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.circulating_supply < arg0.total_supply, 0);
        assert!(arg2 >= 1, 3);
        assert!(get_account_balance(arg0, 0x2::tx_context::sender(arg3)) < arg0.maximum_one_account, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= 1, 1);
        0x2::priority_queue::insert<address>(&mut arg0.claim_queue, arg2, 0x2::tx_context::sender(arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.coin, 0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg3));
    }

    public entry fun confirm_to_next_round(arg0: &mut MistHouse, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(arg0.circulating_supply < arg0.total_supply, 0);
        assert!(arg0.round <= 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::calculate_round(0x2::clock::timestamp_ms(arg1)), 2);
        0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::verify_drand_signature(arg2, arg3, arg0.round);
        let v0 = arg0.lim;
        if (arg0.need_rand) {
            v0 = 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::rand(arg2, arg0.lim) + arg0.lim;
        };
        let v1 = 0;
        let v2 = 0x2::priority_queue::priorities<address>(&arg0.claim_queue);
        while (v1 < 0x2::math::min(arg0.mist_round_message, 0x1::vector::length<u64>(&v2))) {
            if (arg0.total_supply - arg0.circulating_supply < v0) {
                v0 = arg0.total_supply - arg0.circulating_supply;
            };
            let (_, v4) = 0x2::priority_queue::pop_max<address>(&mut arg0.claim_queue);
            let v5 = v4;
            if (0x2::vec_map::contains<address, u64>(&arg0.account_map, &v5)) {
                let v6 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.account_map, &v5);
                let v7 = *v6 + v0;
                if (v7 > arg0.maximum_one_account) {
                    v1 = v1 + 1;
                    continue
                };
                *v6 = v7;
            } else {
                0x2::vec_map::insert<address, u64>(&mut arg0.account_map, v5, v0);
            };
            arg0.circulating_supply = arg0.circulating_supply + v0;
            v1 = v1 + 1;
        };
        arg0.round = arg0.round + 1;
    }

    public entry fun confirm_to_next_round2(arg0: &mut MistHouse, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(arg0.circulating_supply < arg0.total_supply, 0);
        assert!(arg0.round <= 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::calculate_round(0x2::clock::timestamp_ms(arg1)), 2);
        0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::verify_drand_signature(arg2, arg3, arg0.round);
        let v0 = arg0.lim;
        if (arg0.need_rand) {
            v0 = 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::rand(arg2, arg0.lim) + arg0.lim;
        };
        let v1 = 0;
        while (v1 < arg0.mist_round_message) {
            if (arg0.total_supply - arg0.circulating_supply < v0) {
                v0 = arg0.total_supply - arg0.circulating_supply;
            };
            let (_, v3) = 0x2::priority_queue::pop_max<address>(&mut arg0.claim_queue);
            let v4 = v3;
            if (0x2::vec_map::contains<address, u64>(&arg0.account_map, &v4)) {
                let v5 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.account_map, &v4);
                let v6 = *v5 + v0;
                if (v6 > arg0.maximum_one_account) {
                    v1 = v1 + 1;
                    continue
                };
                *v5 = v6;
            } else {
                0x2::vec_map::insert<address, u64>(&mut arg0.account_map, v4, v0);
            };
            arg0.circulating_supply = arg0.circulating_supply + v0;
            v1 = v1 + 1;
        };
        arg0.round = arg0.round + 1;
    }

    public entry fun confirm_to_next_round3(arg0: &mut MistHouse, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(arg0.circulating_supply < arg0.total_supply, 0);
        assert!(arg0.round <= 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::calculate_round(0x2::clock::timestamp_ms(arg1)), 2);
        let v0 = arg0.lim;
        if (arg0.need_rand) {
            0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::verify_drand_signature(arg2, arg3, arg0.round);
            v0 = 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::rand(arg2, arg0.lim) + arg0.lim;
        };
        let v1 = 0;
        while (v1 < arg0.mist_round_message) {
            if (arg0.total_supply - arg0.circulating_supply < v0) {
                v0 = arg0.total_supply - arg0.circulating_supply;
            };
            let (_, v3) = 0x2::priority_queue::pop_max<address>(&mut arg0.claim_queue);
            let v4 = v3;
            if (0x2::vec_map::contains<address, u64>(&arg0.account_map, &v4)) {
                let v5 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.account_map, &v4);
                let v6 = *v5 + v0;
                if (v6 > arg0.maximum_one_account) {
                    v1 = v1 + 1;
                    continue
                };
                *v5 = v6;
            } else {
                0x2::vec_map::insert<address, u64>(&mut arg0.account_map, v4, v0);
            };
            arg0.circulating_supply = arg0.circulating_supply + v0;
            v1 = v1 + 1;
        };
        arg0.round = arg0.round + 1;
    }

    public entry fun confirm_to_next_round4(arg0: &mut MistHouse, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(arg0.circulating_supply < arg0.total_supply, 0);
        assert!(arg0.round <= 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::calculate_round(0x2::clock::timestamp_ms(arg1)), 2);
        0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::verify_drand_signature(arg2, arg3, arg0.round);
        let v0 = arg0.lim;
        if (arg0.need_rand) {
            v0 = 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::rand::rand(arg2, arg0.lim) + arg0.lim;
        };
        let v1 = 0;
        let v2 = 0x2::priority_queue::priorities<address>(&arg0.claim_queue);
        while (v1 < 0x2::math::min(arg0.mist_round_message, 0x1::vector::length<u64>(&v2))) {
            if (arg0.total_supply - arg0.circulating_supply < v0) {
                v0 = arg0.total_supply - arg0.circulating_supply;
            };
            let (_, v4) = 0x2::priority_queue::pop_max<address>(&mut arg0.claim_queue);
            let v5 = v4;
            if (0x2::vec_map::contains<address, u64>(&arg0.account_map, &v5)) {
                let v6 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.account_map, &v5);
                let v7 = *v6 + v0;
                if (v7 > arg0.maximum_one_account) {
                    v1 = v1 + 1;
                    continue
                };
                *v6 = v7;
            } else {
                0x2::vec_map::insert<address, u64>(&mut arg0.account_map, v5, v0);
            };
            arg0.circulating_supply = arg0.circulating_supply + v0;
            v1 = v1 + 1;
        };
        arg0.round = arg0.round + 1;
    }

    public entry fun destroy(arg0: Mist, arg1: &0x2::tx_context::TxContext) {
        let Mist {
            id           : v0,
            tick         : _,
            utxo         : v2,
            balance      : _,
            content_type : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun destroy_publisher(arg0: 0x2::package::Publisher) {
        0x2::package::burn_publisher(arg0);
    }

    public fun get_account_balance(arg0: &MistHouse, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.account_map, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.account_map, &arg1)
        } else {
            0
        }
    }

    fun init(arg0: MIST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{tick}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://src-inscription.vercel.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNTAuNDYgMzA3Ljg3Ij48ZGVmcz48c3R5bGU+LmNscy0xe2ZpbGw6IzhmYzVmZjt9PC9zdHlsZT48L2RlZnM+PGcgaWQ9IuWbvuWxgl8yIiBkYXRhLW5hbWU9IuWbvuWxgiAyIj48ZyBpZD0i5Zu+5bGCXzEtMiIgZGF0YS1uYW1lPSLlm77lsYIgMSI+PHBhdGggY2xhc3M9ImNscy0xIiBkPSJNMTk1LjIxLDI3NC42YzMuNDcsMS42Miw2LjQ0LDIuOCw5LjE3LDQuMzlhNSw1LDAsMCwxLDEuNzksMy4yN0ExOC4wOCwxOC4wOCwwLDAsMSwyMDMuNTksMjk0Yy0uODcsMS41My0yLjY3LDMuMzEtNC4yNCwzLjUyYTE5MC4xNSwxOTAuMTUsMCwwLDEtMjEuNjgsMS45M2MtNS4zMS4xLTExLTYuMjctMTEtMTEuNjUsMC0xLjUyLDEtMywxLjc5LTUuMjgtMi4zMy4zOS00LjMzLjY1LTYuMjksMS4wNy0xLjI0LjI2LTIuNDEuODYtMy42NSwxLjEtMi41OC41MS01LjE5Ljg4LTcuOCwxLjI4YTMsMywwLDAsMS0xLjczLDBjLTMuMTItMS43My01Ljg2LTEuMDctOC41LDEtLjMyLjI1LS45My4xMi0xLjY3LjE5LDIuODUsMy4wNSwyLjE5LDYuMTQsMS4wNSw5LjQ5LTIuMzUsNi45NC03LjgyLDkuMDYtMTQuMjYsMTAuNjEtNi4yMiwxLjQ5LTEyLS4zNy0xNy44Mi0xLjM3LTYuMzctMS4xMS05LTYuNzQtMTAuOC0xMi4zMy0uOC0yLjQ1LDEuNjMtNi41LDQuMDUtNy43NiwxLjE3LS42MSwyLjM2LTEuMTgsNC4yNC0yLjEyLTMuODUtMS40NS03LTIuNjEtMTAuMDctMy44MS0uNjItLjI0LTEuNi0uNDktMS43Mi0uOTMtMS0zLjM4LTQuMS00LjEzLTYuNjgtNS4yNGE0Ny4yOSw0Ny4yOSwwLDAsMS0xNC44Ny0xMC42MmMtMy42Mi0zLjY1LTcuNzUtNi45MS0xMC44Mi0xMS00Ljg1LTYuNDEtOS43OS0xMy0xMy4yNC0yMC4xNC00Ljk0LTEwLjI3LTcuMjgtMjEuNS04LjI2LTMyLjg4LS4zNC00LC4yMS04LjA3LjI1LTEyLjExLjA3LTUuNTEtLjExLTExLC4xMi0xNi41M2E1Ny42OSw1Ny42OSwwLDAsMSwxLjM1LTEwLjY0YzEuNDctNi40LDIuODctMTIuODksNS4xOC0xOSwxLjY5LTQuNDQsNC43OS04LjM1LDcuMy0xMi40Ny40Ni0uNzUsMS4xOS0xLjMyLDEuNjMtMi4wNyw3LjA3LTEyLjMyLDE4LjM1LTIwLjQxLDI5LjEyLTI5Qzg4LjIsOTQuMzUsOTEuNSw5MSw5NS4xOCw4OC4xNmMyLjg2LTIuMiw2LjE2LTMuODMsOS4xMi01LjkxLDkuMTctNi40NSwxOC43Mi0xMi40LDI1LjQ5LTIxLjc1LDIuMjgtMy4xNiwyLjIxLTYuMzIsMS41OC05LjY3YTYuNDksNi40OSwwLDAsMSwyLTYuNTljMi4yMy0yLDUuMzUtMS4yNSw2LDEuN3MuNzEsNS45MSwxLjU0LDguNzJjLjcsMi4zNCwxLjYsNS4xMSwzLjM1LDYuNTQsNS40MSw0LjQ1LDExLjI4LDguMzQsMTcsMTIuNDYsMS44OSwxLjM4LDMuNDgsMy40MSw2LjI2LDIuNzgsMy4xNiwzLjg5LDguNDYsNC4xMSwxMi4yLDcuMDZhMTAuNywxMC43LDAsMCwwLDMuMTQsMS4yMWMxLC45LDEuNzQsMiwyLjc3LDIuNDQsMy4yNCwxLjQ4LDYuNjMsMi42NCw5Ljg5LDQuMDksOC45Myw0LDE1LjU2LDExLDIyLjc3LDE3LjI1LDMuMzksMyw3LjEzLDUuNjUsMTAsOS4wNywzLjE1LDMuNzksNS4zNiw4LjM0LDguMTUsMTIuNDQsMS44NywyLjc0LDQsNS4yOCw2LjA3LDcuOTJhNS42LDUuNiwwLDAsMSwxLjE0LDEuNjZjMi41Niw5LjQ0LDUuNzEsMTguNzYsNS40MywyOC43NC0uMDcsMi42Ny0uOCw1LjY5LjIsNy45MiwyLjA1LDQuNTkuNjgsOS4xOSwxLjE1LDEzLjc0LjY1LDYuMTgtMS4xOCwxMi4wOC0yLjY4LDE3Ljg5LTIuMTUsOC4zNS01LjA5LDE2LjUxLTcuNzksMjQuNzEtLjUxLDEuNTQtMS42MiwyLjg3LTIuMTksNC4zOS0xLDIuNzktMS43Miw1LjcxLTIuODYsOC40Ni0uOTQsMi4yOC0yLjQ1LDQuMzMtMy40OCw2LjU4YTIzLjU0LDIzLjU0LDAsMCwxLTExLjA4LDExLjI5Yy00LjA5LDIuMTUtNy41Myw1LjQ4LTExLjU0LDcuODItMi4wNywxLjIxLTQuNzQsMS40Mi03LjE1LDJDMTk5LjU2LDI3My42NSwxOTcuNTUsMjc0LjA3LDE5NS4yMSwyNzQuNlptLTI4Ljc5LTE3LjQxLjM0Ljk1YTQ3Ljg3LDQ3Ljg3LDAsMCwwLDYuNDMtMi4zNyw0MS4zLDQxLjMsMCwwLDAsNS43NS00LjA3YzMuMTQtMi40Miw2LjE2LTUsOS4zNC03LjM1LDMuNTItMi42LDcuMjktNC44NywxMC43NC03LjU0YTk1LjYsOTUuNiwwLDAsMCw4LTcuMjFjLjg3LS44NSwxLjItMi4yMiwyLTMuMTNhODIuNzUsODIuNzUsMCwwLDAsMTAuOS0xNC4xMmMyLjY5LTQuNTcsNS40Ni04LjcxLDUuNzItMTQuMjEuMjEtNC40OSwxLTguOTUsMS41My0xMy40My4xOS0xLjYuNDMtMy4yLjU4LTQuOGE0LjM3LDQuMzcsMCwwLDAtLjE5LTEuODRjLS43NC0yLTEuNjItMy45My0yLjM3LTUuOTItMi01LjI0LTMuNTctMTAuNjgtNy4zMy0xNS4wNS0uODItLjk1LTIuMjEtMS44MS0yLjM1LTIuODUtLjU3LTQuMDctMy40OC02LjQ5LTUuOTQtOS4yMy0zLjY2LTQuMDctNy40NC04LTExLjEzLTEyLjA3YTM2LjEyLDM2LjEyLDAsMCwwLTIuMzYtMi45NGMtNC42OC00LjExLTkuNTMtOC0xNC4xNS0xMi4yMi03LjY1LTYuOTQtMTYuNjQtMTEuNzQtMjUuNzgtMTYuMjRhNDAuNzYsNDAuNzYsMCwwLDEtMTIuODEtOS42MWMtMi42MS0zLTQuMTQtMi45NC02LjIzLjMzLTMuNyw1LjgxLTksOS44LTE0LjYzLDEzLjUxYTEwMi42OSwxMDIuNjksMCwwLDAtMTEuNjgsOWMtNS40Niw0LjgtMTAuNjcsOS45LTE2LDE0Ljg2YTksOSwwLDAsMS0xLC42MmMtMywyLjA4LTYuNiwzLjYzLTguNzQsNi4zNmEyMTUuODMsMjE1LjgzLDAsMCwwLTE0LjMsMjAuNjdjLTEuOCwyLjk0LTIuNDcsNi42Ny0zLjI2LDEwLjEyLTEuMjIsNS4zOS0xLjc5LDEwLjk1LTMuMjQsMTYuMjctMS4xMSw0LjA2LS42OCw3LjgzLjA5LDExLjc3LjM5LDIsMSw0LjI4LjMzLDZhMTAuNTgsMTAuNTgsMCwwLDAsLjEzLDcuMjIsNDUuNTQsNDUuNTQsMCwwLDAsMi42NCw3YzEuMTYsMi4zMSwzLDQuMjgsNC4wNiw2LjYzLDEuMjcsMi45MiwyLjM0LDUuNzMsNC42NCw4LjE4LDMuNDMsMy42NCw2LjE3LDcuOTIsOS40LDExLjc2LjkyLDEuMTEsMi43MywxLjQ2LDMuNzUsMi41MiwzLjQyLDMuNiw3Ljg2LDUuNjEsMTIsOC4xNSwxLjI1Ljc4LDMuNjMuMDcsMy42OSwyLjY0LDAsLjE5LDEuMTcuNDMsMS44MS40OSwxLjA3LjEsMi4yNS0uMjEsMy4xOS4xNSw2LjEsMi4zMiwxMi4xNyw0LjYxLDE4Ljg2LDIuNmEyLjM5LDIuMzksMCwwLDEsLjg3LjA3YzMuMjMuMjMsNi40Ni41NCw5LjcuNjgsMi4zMS4xLDQuNTctLjI2LDYuNTgsMS41OC42NC41OSwzLjExLjQ2LDMuMzYsMCwxLTIuMDksMi43My0xLjQ0LDQuMjYtMS41M2E3NSw3NSwwLDAsMCw3LjUyLS40M0EyOC42NCwyOC42NCwwLDAsMCwxNjYuNDIsMjU3LjE5WiIvPjxwYXRoIGNsYXNzPSJjbHMtMSIgZD0iTTE1OC42NSwyMi4xMmE2OC4xNyw2OC4xNywwLDAsMSw4LjU2LDIuMjdjMy43NSwxLjUxLDUuMSw0LjgzLDUuMTIsOC42OSwwLDMuNTctMS43LDUuNzYtNS40OSw3LjI3LTYuNTUsMi42LTguNjQsMS4zOS0xMC4xOS01LjU0YTQuOTMsNC45MywwLDAsMC0yLjQyLTIuNzJjLTIuNTUtMS4zNi03LjI2Ljc3LTguNTgsMy43Ni0uNTQsMS4yMy0xLjQ4LDIuODctMi42LDIuMTFhNC43LDQuNywwLDAsMS0xLjI4LTQuNDFBMTQuMjUsMTQuMjUsMCwwLDEsMTQ1LDI3LjMxQzE0OC42OCwyNC4xNywxNTIuMjEsMjEuNywxNTguNjUsMjIuMTJaIi8+PHBhdGggY2xhc3M9ImNscy0xIiBkPSJNMTM5LjA1LDI4LjQ0Yy01LjY5LTMuMjEtMTAuODMtNi40NC0xMy4yOC0xMi41NS0yLjExLTUuMjcuMzEtMTIuODIsNS4xMi0xNWE4LjIxLDguMjEsMCwwLDEsOC45Mi44OGMxLjg1LjY0LDEuODgsNi40OS0uMDYsOWExMi4xNCwxMi4xNCwwLDAsMC0zLDguODdDMTM2Ljg1LDIyLjIsMTM3Ljg3LDI1LjMyLDEzOS4wNSwyOC40NFoiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik03NS4zNiwyNzkuNzdjMi43MSwwLDUuNDMtLjEsOC4xNC4wNWEzLjQ5LDMuNDksMCwwLDEsMi4zMywxLjJjMi40LDMuMzEtLjY3LDEwLjA1LTQuNzYsMTAuMzZhMTE4Ljg2LDExOC44NiwwLDAsMS0xNC4xMS41M2MtMy0uMTUtNi42LTUuNjctNS44MS04LjU5YTQuNiw0LjYsMCwwLDEsMi42OS0yLjU4LDIyLjQ4LDIyLjQ4LDAsMCwxLDUuNy0uODFjMS45My0uMTMsMy44OCwwLDUuODIsMFoiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik0xMjguMywzNi40OWMtMS0xLjMtMS4zMi0yLjYyLTQuMi0yLjc3LTEuMzksMC0yLjUxLDEuMTItMy4yNiwzLjI3LTEuNDgsNC4yNC0zLjcxLDUuOTItNi44MSw1LjU1YTUuMTQsNS4xNCwwLDAsMS0yLjc5LTEuMjhjLTQuMzgtNC4yNC00LjE4LTEwLC4zOS0xNGE3LjY2LDcuNjYsMCwwLDEsMS4xMi0uODhjNi4zOC0yLjUzLDkuODktMS40MSwxMy43OS44MUE3LjA3LDcuMDcsMCwwLDEsMTI4LjMsMzYuNDlaIi8+PHBhdGggY2xhc3M9ImNscy0xIiBkPSJNMzkuNTQsMjc0Yy0yLjYxLS4xOC01LjIzLS4zLTcuODMtLjU3LTIuMzctLjI0LTIuOTEtMi0yLjg3LTRhMywzLDAsMCwxLDMuMjktMy4yNWM0Ljc1LjA2LDkuNS4xOCwxNC4yNi4yNiwyLjcxLDAsMywxLjk1LDMuMTUsNCwuMTgsMi4zOC0xLjU2LDMuMDYtMy4zLDMuMjZhNTcuMzgsNTcuMzgsMCwwLDEtNi42OS4wNloiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik05LjE3LDI1NmE0OC4wOCw0OC4wOCwwLDAsMSw2LjY5LjEsMy41MiwzLjUyLDAsMCwxLDIuMzgsMi4xMWMuNDUsMS43Ny0xLDEuOTItMi40LDEuOTItNC4yMiwwLTguNDUuMS0xMi42Ny4xYTIuNDEsMi40MSwwLDAsMS0xLjYyLS41NUExNC45MywxNC45MywwLDAsMSwwLDI1Ny4zYy43My0uNDMsMS40My0xLjE4LDIuMTgtMS4yM0M0LjUsMjU1LjkxLDYuODQsMjU2LDkuMTcsMjU2WiIvPjxwYXRoIGNsYXNzPSJjbHMtMSIgZD0iTTE3MC44MiwxNTYuNjNjNC44Ni0xLDkuNSw0LDkuODksOC41NnMtNC43Myw5LjU1LTkuMzgsOS4zMmMtNS4yOS0uMjctOS41Ny00LTkuNzMtOS4xNUMxNjEuNDcsMTYxLjA4LDE2Ni4xMSwxNTYuNjksMTcwLjgyLDE1Ni42M1oiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik0xMjUuMTEsMTU2LjYzYzQuNzktLjk1LDEwLjE1LDMuOTIsMTAuMjUsOC41MS4xLDUuMTgtNC4yLDkuMjctOS44Niw5LjMxLTQuNDIsMC04LjgtMy4zMS04LjkyLTYuNzlDMTE2LjM3LDE2MS4yNSwxMTkuOSwxNTYuNjgsMTI1LjExLDE1Ni42M1oiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik0xNTIuODcsMTgyYTkuNDMsOS40MywwLDAsMSwyLjMyLDBjLjgyLjIyLDIuMTUuNjcsMi4yMSwxLjE1YTQuOTMsNC45MywwLDAsMS0uNjIsMy40NmMtMS45NCwyLjMzLTguNTcsMi4zNS0xMC43Ni4yNy0xLjgxLTEuNzMtMS43LTMuMDcuNjEtMy45YTQ2Ljg4LDQ2Ljg4LDAsMCwxLDYuMTgtMS4zN1oiLz48L2c+PC9nPjwvc3ZnPg=="));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{\"p\":\"sui-20\",\"op\":\"mint\",\"tick\":\"{tick}\",\"amt\":\"{balance}\"}"));
        let v4 = 0x2::package::claim<MIST>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Mist>(&v4, v0, v2, arg1);
        let v6 = MistHouse{
            id                  : 0x2::object::new(arg1),
            tick                : 0x1::string::utf8(b"mist"),
            lim                 : 1000,
            circulating_supply  : 0,
            total_supply        : 210000000,
            claim_queue         : 0x2::priority_queue::new<address>(0x1::vector::empty<0x2::priority_queue::Entry<address>>()),
            coin                : 0x2::coin::zero<0x2::sui::SUI>(arg1),
            account_map         : 0x2::vec_map::empty<address, u64>(),
            mist_round_message  : 300,
            need_rand           : false,
            maximum_one_account : 20000,
            round               : 3568406,
        };
        let v7 = 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut v7, 0x1::string::utf8(b"mist"), 0x2::object::id<MistHouse>(&v6));
        let v8 = InscriptionHouse{
            id               : 0x2::object::new(arg1),
            inscription_info : v7,
            inscriptions     : 0x2::table_vec::singleton<0x1::string::String>(0x1::string::utf8(b"mist"), arg1),
        };
        0x2::display::update_version<Mist>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Mist>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MistHouse>(v6);
        0x2::transfer::share_object<InscriptionHouse>(v8);
    }

    public entry fun mint(arg0: &mut MistHouse, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.circulating_supply == arg0.total_supply, 2);
        let v0 = 0x2::tx_context::sender(arg1);
        let (_, v2) = 0x2::vec_map::remove<address, u64>(&mut arg0.account_map, &v0);
        let v3 = v2;
        let v4 = 100;
        while (v3 > 0 && v4 > 0) {
            v4 = v4 - 1;
            let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0.coin, 1, arg1);
            if (v3 > 1000) {
                v3 = v3 - 1000;
                let v6 = Mist{
                    id           : 0x2::object::new(arg1),
                    tick         : arg0.tick,
                    utxo         : v5,
                    balance      : 1000,
                    content_type : 0x1::string::utf8(b"sui-20"),
                };
                0x2::transfer::public_transfer<Mist>(v6, 0x2::tx_context::sender(arg1));
                continue
            };
            let v7 = Mist{
                id           : 0x2::object::new(arg1),
                tick         : arg0.tick,
                utxo         : v5,
                balance      : v3,
                content_type : 0x1::string::utf8(b"sui-20"),
            };
            v3 = 0;
            0x2::transfer::public_transfer<Mist>(v7, 0x2::tx_context::sender(arg1));
        };
    }

    public fun mist_balance(arg0: &Mist) : u64 {
        arg0.balance
    }

    public fun mist_coin_value(arg0: &Mist) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.utxo)
    }

    public fun mist_content_type(arg0: &Mist) : 0x1::string::String {
        arg0.content_type
    }

    public fun mist_tick(arg0: &Mist) : 0x1::string::String {
        arg0.tick
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

