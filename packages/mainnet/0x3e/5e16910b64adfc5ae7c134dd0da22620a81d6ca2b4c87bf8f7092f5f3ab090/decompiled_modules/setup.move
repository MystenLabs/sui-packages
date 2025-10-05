module 0x3e5e16910b64adfc5ae7c134dd0da22620a81d6ca2b4c87bf8f7092f5f3ab090::setup {
    public entry fun create_state(arg0: &0x2::package::Publisher, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x3e5e16910b64adfc5ae7c134dd0da22620a81d6ca2b4c87bf8f7092f5f3ab090::state::State>(0x3e5e16910b64adfc5ae7c134dd0da22620a81d6ca2b4c87bf8f7092f5f3ab090::state::new(arg0, arg1, arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

