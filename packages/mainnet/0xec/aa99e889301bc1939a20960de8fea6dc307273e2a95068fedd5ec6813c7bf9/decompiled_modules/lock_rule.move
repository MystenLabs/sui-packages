module 0xecaa99e889301bc1939a20960de8fea6dc307273e2a95068fedd5ec6813c7bf9::lock_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        permanent: bool,
    }

    public fun add(arg0: &mut 0xecaa99e889301bc1939a20960de8fea6dc307273e2a95068fedd5ec6813c7bf9::signing_policy::SigningPolicy, arg1: &0xecaa99e889301bc1939a20960de8fea6dc307273e2a95068fedd5ec6813c7bf9::signing_policy::SigningPolicyCap, arg2: bool) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{permanent: arg2};
        0xecaa99e889301bc1939a20960de8fea6dc307273e2a95068fedd5ec6813c7bf9::signing_policy::add_stackable_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun is_permanent(arg0: &Config) : bool {
        arg0.permanent
    }

    public fun prove(arg0: &mut 0xecaa99e889301bc1939a20960de8fea6dc307273e2a95068fedd5ec6813c7bf9::signing_policy::SigningRequest, arg1: &0xecaa99e889301bc1939a20960de8fea6dc307273e2a95068fedd5ec6813c7bf9::signing_policy::SigningPolicy, arg2: &0xecaa99e889301bc1939a20960de8fea6dc307273e2a95068fedd5ec6813c7bf9::umi_signer::UmiSigner, arg3: vector<u8>) {
        let v0 = 0xecaa99e889301bc1939a20960de8fea6dc307273e2a95068fedd5ec6813c7bf9::umi_signer::new_chain_id(arg3);
        assert!(0xecaa99e889301bc1939a20960de8fea6dc307273e2a95068fedd5ec6813c7bf9::umi_signer::has_wallet(arg2, v0) && 0xecaa99e889301bc1939a20960de8fea6dc307273e2a95068fedd5ec6813c7bf9::umi_signer::is_locked(arg2, v0), 0);
        let v1 = Rule{dummy_field: false};
        0xecaa99e889301bc1939a20960de8fea6dc307273e2a95068fedd5ec6813c7bf9::signing_policy::add_receipt<Rule>(v1, arg0);
    }

    // decompiled from Move bytecode v6
}

