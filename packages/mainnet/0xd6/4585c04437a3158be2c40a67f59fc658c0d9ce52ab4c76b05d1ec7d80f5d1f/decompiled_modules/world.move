module 0xd64585c04437a3158be2c40a67f59fc658c0d9ce52ab4c76b05d1ec7d80f5d1f::world {
    struct WORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORLD>(arg0, 9, b"WORLD", b"10k.world", b"This is a 10k.world memecoin launched on sui meme fun pad. We will play a whale game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ab7dac86785213dc00550584ea682089blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WORLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

