module 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::controller {
    public entry fun pause(arg0: &mut 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::is_emergency(arg0), 202);
        assert!(0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::is_emergency(arg0), 203);
        assert!(0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

