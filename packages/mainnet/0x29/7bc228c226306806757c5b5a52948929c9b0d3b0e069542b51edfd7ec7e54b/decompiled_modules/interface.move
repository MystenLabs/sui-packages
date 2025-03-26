module 0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::interface {
    public entry fun claim(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &mut 0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::Staking, arg3: &0x2::clock::Clock, arg4: 0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::UnstakeTicket, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::withdraw_stake(arg0, arg1, arg2, arg3, arg4, arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun request_stake(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg1: &mut 0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::Staking, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::hawal::HAWAL>>(0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::request_stake_coin(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun request_unstake_delay(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &mut 0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::Staking, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::hawal::HAWAL>, arg5: &mut 0x2::tx_context::TxContext) {
        0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::walstaking::request_withdraw_stake(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

