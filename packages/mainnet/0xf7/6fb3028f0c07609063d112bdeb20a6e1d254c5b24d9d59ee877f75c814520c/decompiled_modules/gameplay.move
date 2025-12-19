module 0xf76fb3028f0c07609063d112bdeb20a6e1d254c5b24d9d59ee877f75c814520c::gameplay {
    public entry fun end_round(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg1: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::gameplay::Gameplay, arg2: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::gameplay::get_miner_info(arg1, arg5);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::gameplay::end_round(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::gameplay::get_miner_info(arg1, arg5);
        assert!(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_rewards_aur(&v1) >= 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_rewards_aur(&v0) + 1000000000, 999);
    }

    // decompiled from Move bytecode v6
}

