module 0xfc050b08f3603c23363ef67479e0c7d472b004d69ff19572b204386be84e00a2::osu {
    struct OSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OSU>(arg0, 6, b"OSU", b"OracleSui Bot", b"OracleSui ($oSU) is the first price oracle exclusively dedicated to memecoins launched on the SuiAI platform. Developed to bring transparency and reliable data to the volatile memecoin market, OracleSui aims to solve the lack of accurate information, allowing traders and investors to make more informed decisions...With the exponential growth of the SuiAI ecosystem and the continuous emergence of new memecoins, the need for a reliable oracle has become pressing. OracleSui fills this gap by providing real-time, high-accuracy price feeds for a wide range of memecoins, from the most popular to the newly launched.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Captura_de_tela_2025_07_18_113637_8d2164ed81.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OSU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

