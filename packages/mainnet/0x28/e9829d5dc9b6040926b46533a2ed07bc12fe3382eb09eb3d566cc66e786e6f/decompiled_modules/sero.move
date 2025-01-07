module 0x28e9829d5dc9b6040926b46533a2ed07bc12fe3382eb09eb3d566cc66e786e6f::sero {
    struct SERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SERO>(arg0, 6, b"Sero", b"Suib zero", b"SuiB Zero was a rare meme coin representing the power of water and ice in the crypto world. While fast and chaotic meme coins like Doge and Shiba Inu dominated, SuiB Zero froze transaction chains to restore balance. Whenever these coins got out of control, SuiB Zero would step in, covering everything in ice. Yet, the flow of water never fully stopped; once the ice melted, the system rebalanced, and meme coins flowed more steadily. SuiB Zero remained a legendary force, ensuring equilibrium in the chaotic world of crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ads_Ae_z_tasar_Ae_m_8_f1dff8d548.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

