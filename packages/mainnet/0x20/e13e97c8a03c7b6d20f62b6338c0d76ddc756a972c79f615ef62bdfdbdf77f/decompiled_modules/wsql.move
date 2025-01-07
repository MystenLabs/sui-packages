module 0x20e13e97c8a03c7b6d20f62b6338c0d76ddc756a972c79f615ef62bdfdbdf77f::wsql {
    struct WSQL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSQL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSQL>(arg0, 6, b"WSQL", b"WHIRLY SQUIRREL", b"You didnt come this far to stop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_051454636_fe1b070cf5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSQL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSQL>>(v1);
    }

    // decompiled from Move bytecode v6
}

