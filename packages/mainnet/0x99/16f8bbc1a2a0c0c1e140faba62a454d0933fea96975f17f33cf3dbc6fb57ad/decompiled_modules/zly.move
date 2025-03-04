module 0x9916f8bbc1a2a0c0c1e140faba62a454d0933fea96975f17f33cf3dbc6fb57ad::zly {
    struct ZLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZLY>(arg0, 9, b"Zly", x"7a656c656e736bc4b179", b"meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4e33cc8a566ae194bb33448cfb443ec9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

