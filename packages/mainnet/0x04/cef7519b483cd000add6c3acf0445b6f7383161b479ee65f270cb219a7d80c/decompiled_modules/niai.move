module 0x4cef7519b483cd000add6c3acf0445b6f7383161b479ee65f270cb219a7d80c::niai {
    struct NIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIAI>(arg0, 6, b"NIAI", b"Network Integrator", x"4e6574776f726b20496e7465677261746f7220546f6b656e20566973696f6e3a0a22546f2062652061206c656164696e6720626c6f636b636861696e20736f6c7574696f6e207468617420656d706f7765727320636f6c6c61626f726174696f6e206163726f7373206469676974616c2065636f73797374656d732c20666163696c69746174657320696e7465722d6e6574776f726b20636f6e6e65637469766974792c20616e6420656e61626c657320757365727320746f207365616d6c6573736c7920696e74657261637420696e206120646563656e7472616c697a656420776f726c642e22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000089052_5d6687443d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

