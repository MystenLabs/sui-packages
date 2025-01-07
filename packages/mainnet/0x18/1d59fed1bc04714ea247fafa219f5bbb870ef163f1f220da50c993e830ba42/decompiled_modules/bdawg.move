module 0x181d59fed1bc04714ea247fafa219f5bbb870ef163f1f220da50c993e830ba42::bdawg {
    struct BDAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDAWG>(arg0, 6, b"BDAWG", b"BullDawg", x"2442444157472c20546f7567682061732062756c6c2c206c6f79616c20617320796f7572206265737420667269656e642c20616e6420616c7761797320726561647920746f206269746520696e746f20746865206e65787420626967206f70706f7274756e6974792e205468697320746f6b656e20646f65736ee2809974206261726b2c20697420626974657320e2809320616e64206974e2809973206865726520746f20484f444c206c696b652061206e6576657220656e64696e6720626f6e6420796f752068617665207769746820796f7572204441574721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731006589733.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDAWG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDAWG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

