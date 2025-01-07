module 0xadfd579ccd324bb0e92833c8dbe941243abd95bf8330b33950be6feeb971e24e::vcd {
    struct VCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCD>(arg0, 6, b"Vcd", b"cdc", b"cd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_a_a_a_a_a_a_a_2024_10_08_202112_316da01ee6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

