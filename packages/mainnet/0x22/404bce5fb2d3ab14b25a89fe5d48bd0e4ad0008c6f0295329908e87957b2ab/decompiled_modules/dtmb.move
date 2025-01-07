module 0x22404bce5fb2d3ab14b25a89fe5d48bd0e4ad0008c6f0295329908e87957b2ab::dtmb {
    struct DTMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTMB>(arg0, 9, b"DTMB", b"D.TrustMeBro", b"Don't trust me bro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/cbb5c7f33ed2499e6bdc40f196cc7caablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTMB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTMB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

