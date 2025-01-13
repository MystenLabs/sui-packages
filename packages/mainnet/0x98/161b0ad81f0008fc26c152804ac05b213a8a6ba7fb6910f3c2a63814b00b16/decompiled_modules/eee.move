module 0x98161b0ad81f0008fc26c152804ac05b213a8a6ba7fb6910f3c2a63814b00b16::eee {
    struct EEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEE>(arg0, 9, b"EEE", b"eee", b"1000000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreic5rvww44r365h66omnrhxft5fsz7v4cliq45xbiv4d4g7isbl7sm?X-Algorithm=PINATA1&X-Date=1736743736&X-Expires=315360000&X-Method=GET&X-Signature=080e2cf3f181cee784014b997bde44b260f49f49d165c8e10539c63982534259"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EEE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EEE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<EEE>>(v2);
    }

    // decompiled from Move bytecode v6
}

