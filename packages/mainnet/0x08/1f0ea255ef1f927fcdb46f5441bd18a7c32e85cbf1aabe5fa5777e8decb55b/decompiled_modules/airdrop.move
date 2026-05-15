module 0x81f0ea255ef1f927fcdb46f5441bd18a7c32e85cbf1aabe5fa5777e8decb55b::airdrop {
    struct Airdropped has copy, drop {
        airdrop_number: u64,
        caller: address,
        coin_type: 0x1::type_name::TypeName,
        recipient_count: u64,
        total_amount: u64,
        fee_paid: u64,
        memo: 0x1::option::Option<0x1::string::String>,
        tx_digest: vector<u8>,
        timestamp_ms: u64,
    }

    public fun airdrop<T0>(arg0: &mut 0x81f0ea255ef1f927fcdb46f5441bd18a7c32e85cbf1aabe5fa5777e8decb55b::platform::AirdropPlatform, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<address>, arg4: vector<u64>, arg5: 0x1::option::Option<0x1::string::String>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x81f0ea255ef1f927fcdb46f5441bd18a7c32e85cbf1aabe5fa5777e8decb55b::platform::assert_not_paused(arg0);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 > 0, 100);
        assert!(v0 <= 0x81f0ea255ef1f927fcdb46f5441bd18a7c32e85cbf1aabe5fa5777e8decb55b::platform::max_recipients_internal(arg0), 101);
        assert!(0x1::vector::length<u64>(&arg4) == v0, 102);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg4, v2);
            assert!(v3 > 0, 103);
            assert!(*0x1::vector::borrow<address>(&arg3, v2) != @0x0, 104);
            v1 = v1 + v3;
            v2 = v2 + 1;
        };
        assert!(0x2::coin::value<T0>(&arg1) >= v1, 200);
        let v4 = 0x81f0ea255ef1f927fcdb46f5441bd18a7c32e85cbf1aabe5fa5777e8decb55b::platform::fee_per_recipient_internal(arg0) * v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v4, 201);
        if (v4 > 0) {
            0x81f0ea255ef1f927fcdb46f5441bd18a7c32e85cbf1aabe5fa5777e8decb55b::platform::deposit_fee(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg2), v4));
        };
        let v5 = 0;
        while (v5 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, *0x1::vector::borrow<u64>(&arg4, v5), arg7), *0x1::vector::borrow<address>(&arg3, v5));
            v5 = v5 + 1;
        };
        let v6 = Airdropped{
            airdrop_number  : 0x81f0ea255ef1f927fcdb46f5441bd18a7c32e85cbf1aabe5fa5777e8decb55b::platform::bump_airdrop_counter(arg0),
            caller          : 0x2::tx_context::sender(arg7),
            coin_type       : 0x1::type_name::with_defining_ids<T0>(),
            recipient_count : v0,
            total_amount    : v1,
            fee_paid        : v4,
            memo            : arg5,
            tx_digest       : *0x2::tx_context::digest(arg7),
            timestamp_ms    : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<Airdropped>(v6);
        (arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

