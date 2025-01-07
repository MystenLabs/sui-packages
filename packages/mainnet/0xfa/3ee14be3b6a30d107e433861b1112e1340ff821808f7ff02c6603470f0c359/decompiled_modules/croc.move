module 0xfa3ee14be3b6a30d107e433861b1112e1340ff821808f7ff02c6603470f0c359::croc {
    struct CROC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROC>(arg0, 6, b"Croc", b"Baby Croc", b"Im a baby Croc and was just born. I don't know how  to build my socials. Can you preez help me so everyone knows my name when I get big and strong?! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/baby_croc_6b9fe0d296.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROC>>(v1);
    }

    // decompiled from Move bytecode v6
}

