module 0xe750a53af6e347d35be3285a381358d2b27946e8d0abb5ceec3fc8255b1a3e94::suiper {
    struct SUIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPER>(arg0, 6, b"Suiper", b"Suiperman", b"The time has come to kick off our #SUIPERMemeBattle! For the next one week, were looking for the best Suiperman-themed memes from our community. Whether youre an experienced meme maker or trying it out for the first time, nows your chance to get creative and showcase your work!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gccf_Nd_LWYAA_9xb1_761d0479c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

