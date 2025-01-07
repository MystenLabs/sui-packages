module 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::is_emergency(arg0), 302);
        assert!(0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::get_mut_pool<T0, T1>(arg0, 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::event::withdrew_event(0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::global_id<T0, T1>(v0), 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

