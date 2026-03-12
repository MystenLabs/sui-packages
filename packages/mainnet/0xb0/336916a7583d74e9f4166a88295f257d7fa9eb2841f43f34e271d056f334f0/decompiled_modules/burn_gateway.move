module 0xb0336916a7583d74e9f4166a88295f257d7fa9eb2841f43f34e271d056f334f0::burn_gateway {
    struct BurnGateway has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<0xd058fad4fc848f7db624b6e9658fd45f1badcf0a9a58897e632135b72e2be3f2::aqusdc::AQUSDC>,
    }

    public fun burn(arg0: &mut BurnGateway, arg1: 0x2::coin::Coin<0xd058fad4fc848f7db624b6e9658fd45f1badcf0a9a58897e632135b72e2be3f2::aqusdc::AQUSDC>) : u64 {
        0x2::coin::burn<0xd058fad4fc848f7db624b6e9658fd45f1badcf0a9a58897e632135b72e2be3f2::aqusdc::AQUSDC>(&mut arg0.treasury_cap, arg1)
    }

    public fun create_gateway(arg0: 0x2::coin::TreasuryCap<0xd058fad4fc848f7db624b6e9658fd45f1badcf0a9a58897e632135b72e2be3f2::aqusdc::AQUSDC>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnGateway{
            id           : 0x2::object::new(arg1),
            treasury_cap : arg0,
        };
        0x2::transfer::share_object<BurnGateway>(v0);
    }

    // decompiled from Move bytecode v6
}

