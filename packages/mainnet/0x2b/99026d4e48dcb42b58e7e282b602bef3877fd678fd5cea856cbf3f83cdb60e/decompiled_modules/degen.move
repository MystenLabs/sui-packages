module 0x2b99026d4e48dcb42b58e7e282b602bef3877fd678fd5cea856cbf3f83cdb60e::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN>(arg0, 0, b"DEGEN", b"Degen", b"For market participants who do not pay attention to important metrics and tokenomics of a digital asset, and do not conduct fundamental and technical analysis. They may make a purchase decision based on unconvincing factors such as a beautiful coin logo or a funny slogan.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/VCXJCzq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEGEN>(&mut v2, 131313131313, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

