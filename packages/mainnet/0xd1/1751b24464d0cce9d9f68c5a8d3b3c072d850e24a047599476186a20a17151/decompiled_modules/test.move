module 0xd11751b24464d0cce9d9f68c5a8d3b3c072d850e24a047599476186a20a17151::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TST", b"Test", b"TestWX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 18400000000000000000, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<TEST>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(arg0);
    }

    public entry fun revoke_treasury(arg0: 0x2::coin::TreasuryCap<TEST>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST>>(arg0);
    }

    public entry fun update_metadata(arg0: &0x2::coin::TreasuryCap<TEST>, arg1: &mut 0x2::coin::CoinMetadata<TEST>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<TEST>(arg0, arg1, arg2);
        0x2::coin::update_symbol<TEST>(arg0, arg1, arg3);
        0x2::coin::update_description<TEST>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<TEST>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

