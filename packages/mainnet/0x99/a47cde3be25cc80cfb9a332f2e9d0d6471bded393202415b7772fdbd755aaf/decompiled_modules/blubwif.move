module 0x99a47cde3be25cc80cfb9a332f2e9d0d6471bded393202415b7772fdbd755aaf::blubwif {
    struct BLUBWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBWIF>(arg0, 6, b"BLUBWIF", b"blubwifhat", b"$BLUBWIF is the ultimate choice for those searching for a new version of BLUB on the Sui network. If you're into Boys Club and edgy cryptocurrencies that break all the rules with high growth potential, $BLUBWIF is the most badass fish in the Sui Ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_35_0d67e138bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

