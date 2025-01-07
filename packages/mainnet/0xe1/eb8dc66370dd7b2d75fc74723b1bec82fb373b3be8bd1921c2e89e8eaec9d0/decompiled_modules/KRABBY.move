module 0xe1eb8dc66370dd7b2d75fc74723b1bec82fb373b3be8bd1921c2e89e8eaec9d0::KRABBY {
    struct PublicRedEnvelope has store, key {
        id: 0x2::object::UID,
        coins: 0x2::table_vec::TableVec<0x2::coin::Coin<KRABBY>>,
    }

    struct KRABBY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KRABBY>, arg1: 0x2::coin::Coin<KRABBY>) {
        0x2::coin::burn<KRABBY>(arg0, arg1);
    }

    public entry fun add_to_envelope(arg0: &mut PublicRedEnvelope, arg1: 0x2::coin::Coin<KRABBY>) {
        0x2::table_vec::push_back<0x2::coin::Coin<KRABBY>>(&mut arg0.coins, arg1);
    }

    fun init(arg0: KRABBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRABBY>(arg0, 2, b"KRABBY", b"krabby", b"No.1 meme coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/GJJJJJJJ/test/main/krabby.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRABBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRABBY>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = PublicRedEnvelope{
            id    : 0x2::object::new(arg1),
            coins : 0x2::table_vec::empty<0x2::coin::Coin<KRABBY>>(arg1),
        };
        0x2::transfer::share_object<PublicRedEnvelope>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KRABBY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KRABBY>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint_multi(arg0: &mut 0x2::coin::TreasuryCap<KRABBY>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            0x2::coin::mint_and_transfer<KRABBY>(arg0, arg1, arg3, arg4);
            v0 = v0 + 1;
        };
    }

    public entry fun take_from_envelope(arg0: &mut PublicRedEnvelope, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KRABBY>>(0x2::table_vec::pop_back<0x2::coin::Coin<KRABBY>>(&mut arg0.coins), 0x2::tx_context::sender(arg1));
    }

    public entry fun take_from_envelope_and_burn(arg0: &mut 0x2::coin::TreasuryCap<KRABBY>, arg1: &mut PublicRedEnvelope) {
        0x2::coin::burn<KRABBY>(arg0, 0x2::table_vec::pop_back<0x2::coin::Coin<KRABBY>>(&mut arg1.coins));
    }

    // decompiled from Move bytecode v6
}

