module 0xca2052fa45a7f750b319dedebd531078ca96b3b8a2d2e1cbc87f9cb1a9d89b9e::labubu {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 6, b"LABUBU", b"LABUBU THE HOTEST TOYS IN THE WORLDS", b"The fluffiest, most chaotic meme token on the SUI Network. Jump into the $LABUBU madness. Pure meme energy on SUI Network, driven by the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicbzsubih7s7sn2jjyy3vs2ldjj3obdgiexltjoaxbyqkvnnlehsq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LABUBU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

