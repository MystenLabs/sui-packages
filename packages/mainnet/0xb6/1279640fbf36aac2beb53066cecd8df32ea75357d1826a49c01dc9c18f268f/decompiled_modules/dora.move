module 0xb61279640fbf36aac2beb53066cecd8df32ea75357d1826a49c01dc9c18f268f::dora {
    struct DORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORA>(arg0, 6, b"DORA", b"DORGAY", b"DORA EXPLORER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/387758836_192785507175310_1208446696779324143_n_6b14a9e20c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

