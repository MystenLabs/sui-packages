module 0x33ad453bb3ccbf1be84171cd4fda7240e51f87ba0db8f5131ce95aef76df8af4::suisage {
    struct SUISAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAGE>(arg0, 6, b"SUISAGE", b"Suisage", b"Make this Suisage happy by forming a community. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUISAGE_PFP_c8096d1b4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

