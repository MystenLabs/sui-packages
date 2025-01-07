module 0x29b8d7460f1a933a9dd8497660f51d1d0928b797901238fc5ea7bbd7b2ef0188::elm {
    struct ELM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELM>(arg0, 4, b"ELM", b"Electrum", b"According to Herodotus, the Lydians were the first people to use gold and silver coins and the first to establish retail shops in permanent locations. Electrum is a naturally occurring alloy of gold and silver, with trace amounts of copper and other metals. It was used as the first coin in the history of humanity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://en.wikipedia.org/wiki/Lydia#/media/File:BMC_06.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELM>(&mut v2, 210000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELM>>(v1);
    }

    // decompiled from Move bytecode v6
}

