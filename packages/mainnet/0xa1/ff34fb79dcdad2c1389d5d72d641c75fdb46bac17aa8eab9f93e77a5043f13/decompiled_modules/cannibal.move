module 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::cannibal {
    struct CANNIBAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANNIBAL, arg1: &mut 0x2::tx_context::TxContext) {
        0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::admin::create_and_transfer(arg1);
    }

    // decompiled from Move bytecode v6
}

