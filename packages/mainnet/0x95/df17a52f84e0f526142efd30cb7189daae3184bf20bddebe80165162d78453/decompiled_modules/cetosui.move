module 0x95df17a52f84e0f526142efd30cb7189daae3184bf20bddebe80165162d78453::cetosui {
    struct CETOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETOSUI>(arg0, 6, b"CETOSUI", b"Cetoddle For Sui", x"4365746f5375690a20436f6d6d756e69747920697320686f6d652c0a77686572652077652062656c6f6e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaw2ullvqlftrd2mr6gf4xcxlfshp72a66ag26lv4dwjws42ktfra")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CETOSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

