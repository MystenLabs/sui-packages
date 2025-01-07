module 0xf698e3bab825adc9a613eced4b945a4367afdff61cc04c4772e700c7d8e7abb0::suitofivedollar {
    struct SUITOFIVEDOLLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOFIVEDOLLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOFIVEDOLLAR>(arg0, 6, b"SUITOFIVEDOLLAR", b"Sui To $5", x"35302520535550504c494553204255524e0a32352520464f52204452495050590a323525204144454e4959490a0a4d41524b4554494e472052454144590a0a574542534954452c5820414e442047524f555020494e434f4d494e47", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9554902_32d60579d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOFIVEDOLLAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOFIVEDOLLAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

