module 0x29b671e53391be700767ac6c696b9329570c97c8cbe4abe28eb8479475e3a119::pohui {
    struct POHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POHUI>(arg0, 6, b"POHUI", b"Proof of highly unconventional intelligence", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT1ZInJabk7RqSPjX5E4nvtrQlcmZnw719_Q&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POHUI>(&mut v2, 104236783000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POHUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

