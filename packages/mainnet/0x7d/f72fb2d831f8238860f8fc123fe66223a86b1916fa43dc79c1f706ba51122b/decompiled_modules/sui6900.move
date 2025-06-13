module 0x7df72fb2d831f8238860f8fc123fe66223a86b1916fa43dc79c1f706ba51122b::sui6900 {
    struct SUI6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI6900>(arg0, 9, b"SUI6900", b"SUI 6900", b"CoinDesc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m.media-amazon.com/images/I/61xa1mU0OYL._AC_UF1000,1000_QL80_.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

