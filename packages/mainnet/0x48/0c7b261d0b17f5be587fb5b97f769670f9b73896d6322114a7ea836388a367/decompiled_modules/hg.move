module 0x480c7b261d0b17f5be587fb5b97f769670f9b73896d6322114a7ea836388a367::hg {
    struct HG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HG>(arg0, 6, b"HG", b"Hungry", b"The first public welfare on Sui ! There will be no plan on social media and website, every time you purchase 1 sui is a big help for the hungry people, do it as you can. Dev will donate 90% of his wallet to the World Food Programme when bund. Lets see how far we can go, for a no-hungry world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_a_c_ae_ae_e_e_c_e_ae_e_a_a_i_ae_e_ae_c_a_5d22bbb37f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HG>>(v1);
    }

    // decompiled from Move bytecode v6
}

