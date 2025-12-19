module 0x2f752e02902441bf11af9883949269a98dad777c89c51cfc74c92ee70cf88bc::gameplay {
    public entry fun end_round(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg1: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::gameplay::Gameplay, arg2: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::gameplay::get_miner_info(arg1, arg5);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::gameplay::end_round(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::gameplay::get_miner_info(arg1, arg5);
        let v2 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_rewards_aur(&v1);
        assert!(v2 >= 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_rewards_aur(&v0) + 1000000000, v2);
    }

    // decompiled from Move bytecode v6
}

