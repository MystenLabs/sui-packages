module 0xb337e7ba75920ff197a9efedb4146758ccc7324a5d3908ae6253fffee32c4228::ucs {
    struct UCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCS>(arg0, 6, b"UCS", b"Cat SUI AI Agent", b".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/318e809d_aeac_4c18_ad4e_e354256a9c6a_c5a89c7793.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

