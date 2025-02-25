module 0x20ff023113619081e33f7652899c098fd2c62b43ca12ddbc342647cecb033904::babes {
    struct BABES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABES>(arg0, 6, b"BaBes", b"Bebascoin", x"5472c3a26e207472e1bb8d6e67207175c3a02079c3aa75207468c6b0c6a16e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/fb6978dd-53a9-49b0-9d33-e3c651049797.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

