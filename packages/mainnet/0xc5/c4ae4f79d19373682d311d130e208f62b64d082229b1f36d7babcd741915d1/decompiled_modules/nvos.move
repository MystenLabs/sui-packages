module 0xc5c4ae4f79d19373682d311d130e208f62b64d082229b1f36d7babcd741915d1::nvos {
    struct NVOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NVOS>(arg0, 6, b"NVOS", b"NVEROLDSUI", b"\"Hello everyone! I'm NVerOld, the lucky fish who just picked up a huge treasure in the Sui network meme world!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_64a42fbeda.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NVOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NVOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

