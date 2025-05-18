module 0x87535f50c5bee85090914a12362a0ee971e1a9dfb36930b3d87b901ebb60cde6::snd {
    struct SND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SND>(arg0, 9, b"SND", b"SANDA", b"SANDA is your new meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0b1ab8aa9465901a65cfc098b5ac1e4ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

