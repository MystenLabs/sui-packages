module 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::controller {
    public entry fun pause(arg0: &mut 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_emergency(arg0), 202);
        assert!(0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_emergency(arg0), 203);
        assert!(0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

