module 0x56306acf2227742aa542c70ae0bb2ba2cad8af8fd60b9e7fa995d31f25d696af::trans {
    struct TRANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRANS>(arg0, 6, b"TRANS", b"Delicious", b"We are here in the crypto space and want to welcome all the dressers to create their own thing and show the crypto space what some sissies can do. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/611e94ce6644b34a9b79865af94f2ed0_1264b832f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

