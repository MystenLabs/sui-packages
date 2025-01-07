module 0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::vesting {
    struct Request has store {
        stakeholder: 0x1::string::String,
        amounts: vector<u64>,
        addresses: vector<address>,
    }

    struct Locked<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        allocation: u64,
        start: u64,
        end: u64,
    }

    public fun destroy_empty(arg0: Locked<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU>) {
        assert!(0x2::balance::value<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU>(&arg0.balance) == 0, 3);
        let Locked {
            id         : v0,
            balance    : v1,
            allocation : _,
            start      : _,
            end        : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU>(v1);
    }

    public fun new(arg0: &mut Request, arg1: &mut 0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::Vault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = if (arg0.stakeholder == 0x1::string::utf8(b"private_sale")) {
            v0 + 274
        } else {
            v0 + 456
        };
        while (0x1::vector::length<address>(&arg0.addresses) != 0) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg0.amounts);
            let v3 = v2;
            let v4 = 0x1::vector::pop_back<address>(&mut arg0.addresses);
            0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::handle_stakeholder(arg1, arg0.stakeholder, v2, arg2);
            if (arg0.stakeholder == 0x1::string::utf8(b"private_sale")) {
                let v5 = v2 / 5;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU>>(0x2::coin::mint<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU>(0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::cap_mut(arg1), v5, arg2), v4);
                v3 = 0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::math::sub(v2, v5);
            };
            let v6 = Locked<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU>{
                id         : 0x2::object::new(arg2),
                balance    : 0x2::balance::increase_supply<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU>(0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::supply_mut(arg1), v3),
                allocation : v3,
                start      : v0,
                end        : v1,
            };
            0x2::transfer::transfer<Locked<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU>>(v6, v4);
        };
    }

    public fun complete(arg0: Request) {
        let Request {
            stakeholder : _,
            amounts     : _,
            addresses   : _,
        } = arg0;
    }

    public fun propose(arg0: &mut 0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::multisig::Multisig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u64>, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0x1::string::utf8(b"private_sale") || arg2 == 0x1::string::utf8(b"team"), 1);
        assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<address>(&arg4), 2);
        let v0 = Request{
            stakeholder : arg2,
            amounts     : arg3,
            addresses   : arg4,
        };
        0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::multisig::create_proposal<Request>(arg0, arg1, v0, arg5);
    }

    public fun start(arg0: 0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::multisig::Proposal) : Request {
        0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::multisig::get_request<Request>(arg0)
    }

    public fun unlock(arg0: &mut Locked<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU> {
        assert!(arg1 <= 0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::math::sub(0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::math::mul_div_down(arg0.allocation, 0x2::tx_context::epoch(arg2) - arg0.start, arg0.end - arg0.start), 0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::math::sub(arg0.allocation, 0x2::balance::value<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU>(&arg0.balance))), 0);
        0x2::coin::from_balance<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU>(0x2::balance::split<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU>(&mut arg0.balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

