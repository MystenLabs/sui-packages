module 0x7f10a705aca408dbaa6ca75b08026d2f499e800586a08e4b2be5b36854a85d1a::angfis {
    struct ANGFIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGFIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGFIS>(arg0, 6, b"ANGFIS", b"ANGLER FISH", b"Dive into the depths of the Sui Network and discover the glowiest, most fin-tastic memecoin in the sea!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001418088_9c9b1c5b46.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGFIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGFIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

