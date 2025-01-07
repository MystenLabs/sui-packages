module 0xc25bfe0b6dca5d77c2c17fbc9ffdc3591262575161247e636181374f10246666::bruce {
    struct BRUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUCE>(arg0, 9, b"BRUCE", b"BRUCE WAYNE", b"A billionaire philanthropist by day and a masked vigilante known as Batman by night, Bruce Wayne embodies justice and resilience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/66a5613e953c61952dc29efcff843f80blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRUCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

