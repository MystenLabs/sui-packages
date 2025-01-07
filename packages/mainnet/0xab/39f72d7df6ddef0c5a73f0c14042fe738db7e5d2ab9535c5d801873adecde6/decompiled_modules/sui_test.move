module 0xab39f72d7df6ddef0c5a73f0c14042fe738db7e5d2ab9535c5d801873adecde6::sui_test {
    struct Sui_Test<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct CoinMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        decimals: u8,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        is_metadata_frozen: bool,
    }

    struct TreasuryCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_supply: 0x2::balance::Supply<T0>,
    }

    public fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (TreasuryCap<T0>, CoinMetadata<T0>) {
        let v0 = TreasuryCap<T0>{
            id           : 0x2::object::new(arg1),
            total_supply : 0x2::balance::create_supply<T0>(arg0),
        };
        let v1 = CoinMetadata<T0>{
            id                 : 0x2::object::new(arg1),
            decimals           : 6,
            name               : 0x1::string::utf8(b"My Token"),
            symbol             : 0x1::ascii::string(b"MyToken"),
            description        : 0x1::string::utf8(b"This is a description of My Token."),
            icon_url           : 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://linkpicture.com/q/waterdrop.png"))),
            is_metadata_frozen : false,
        };
        (v0, v1)
    }

    public entry fun freeze_metadata<T0>(arg0: &TreasuryCap<T0>, arg1: &mut CoinMetadata<T0>) {
        arg1.is_metadata_frozen = true;
    }

    public fun initialize<T0>(arg0: &mut TreasuryCap<T0>, arg1: &mut CoinMetadata<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        mint_and_transfer<T0>(arg0, arg1, 1000000000, arg2, arg3);
        freeze_metadata<T0>(arg0, arg1);
    }

    public fun mint<T0>(arg0: &mut TreasuryCap<T0>, arg1: &CoinMetadata<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Sui_Test<T0> {
        assert!(arg1.is_metadata_frozen, 101);
        Sui_Test<T0>{
            id      : 0x2::object::new(arg3),
            balance : 0x2::balance::increase_supply<T0>(&mut arg0.total_supply, arg2),
        }
    }

    public entry fun mint_and_transfer<T0>(arg0: &mut TreasuryCap<T0>, arg1: &CoinMetadata<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Sui_Test<T0>>(mint<T0>(arg0, arg1, arg2, arg4), arg3);
    }

    public fun total_supply<T0>(arg0: &TreasuryCap<T0>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.total_supply)
    }

    // decompiled from Move bytecode v6
}

