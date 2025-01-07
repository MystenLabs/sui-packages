module 0x7572fe54d4d45f97d9d0a752f623f8a736c57eb89a9a2a9a892839cdb230a921::suinake {
    struct SUINAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAKE>(arg0, 6, b"SUINAKE", b"SUINAKE ON SUI", b"First Snake meme on All chains. SUINAKE is the first crypto snake on the crypto ecosystem! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUINAKKEEE_0788362e9c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

