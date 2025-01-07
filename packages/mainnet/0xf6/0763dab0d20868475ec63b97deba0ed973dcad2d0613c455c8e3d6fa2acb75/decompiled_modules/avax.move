module 0xf60763dab0d20868475ec63b97deba0ed973dcad2d0613c455c8e3d6fa2acb75::avax {
    struct AVAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVAX>(arg0, 6, b"AVAX", b"Avalanche", x"4275696c6420616e797468696e6720796f752077616e742c20616e792077617920796f752077616e74206f6e20746865206c696768746e696e6720666173742c207363616c61626c6520626c6f636b636861696e207468617420776f6ee2809974206c657420796f7520646f776e2e2043686f6f73696e67207468652077726f6e6720626c6f636b636861696e2063616e206b696c6c20796f75722064417070206265666f72652069742065766572206861732061206368616e636520746f20737563636565642c2062757420697420646f65736ee2809974206861766520746f2062652074686973207761792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735596911608.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

