module 0x2f28840f126b6eadfff142e2b27ba4cf26fc8e0e9ae1afc12288e06b42196f30::bolo {
    struct BOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLO>(arg0, 6, b"BOlO", b"BOlO SUI", x"4120636f6c6c656374696f6e206f6620313030207574696c6974792064726976656e20382d62697420706978656c20617274204e465473207468617420756e6c6f636b732061206d656d6265727368697020696e746f20616e20657665722067726f77696e6720636f6d6d756e6974792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_2024_10_20_T210428_852_9959f0d122.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

