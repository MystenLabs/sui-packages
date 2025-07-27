module 0xd216df698d51a4784369ed22423e7198711bd2194c4542500b89581e743b18ff::thespiritofgambling {
    struct THESPIRITOFGAMBLING has drop {
        dummy_field: bool,
    }

    fun init(arg0: THESPIRITOFGAMBLING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THESPIRITOFGAMBLING>(arg0, 9, b"Tokabu", b"The Spirit of Gambling", b"I'm Tokabu, the spirit of gambling. Twitter: https://x.com/TokabuTheSpirit | Telegram: https://t.me/tokabuspirit | Website: https://x.com/TokabuTheSpirit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicrdi3icewusvj5ff53uwnlzng53dmkk3llrmdbn35eb2ozamnhpq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<THESPIRITOFGAMBLING>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THESPIRITOFGAMBLING>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THESPIRITOFGAMBLING>>(v1);
    }

    // decompiled from Move bytecode v6
}

