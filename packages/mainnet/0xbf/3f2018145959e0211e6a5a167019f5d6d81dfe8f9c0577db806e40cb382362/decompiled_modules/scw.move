module 0xbf3f2018145959e0211e6a5a167019f5d6d81dfe8f9c0577db806e40cb382362::scw {
    struct SCW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCW>(arg0, 9, b"SCW", b"Secondary Caw", b"CawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCawCaw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/30e0f69216242b64161f14f0b62057f2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

