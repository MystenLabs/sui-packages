module 0xb311a98330067101e4a9ab849db00a2bcc1963936473f39078ea266887045c25::suilamb {
    struct SUILAMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMB>(arg0, 6, b"SUILAMB", b"Suilamb", x"5355494c414d42204f4e205355492e0a6c6567656e6420696e2053756920636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_20_15_34_22_2285d9b68b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

