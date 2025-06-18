module 0x7568f3df604456f6b51e24738150f677dabd438610d8d4986b9a514121ca7494::zsui {
    struct ZSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZSUI>(arg0, 6, b"ZSUI", b"DragonBallZonSui", b"From Dragon World to the Blockchain, DragonBallZonSui is set to soar. Forget Pokemon, it's Dragon Season!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibotii3ht7wvtctzl3xm5dbd6wdv67bday6vikvoeotdddhpwxt2i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

