module 0xcbe412c029cb4a7487846462e9aa0b324481b64694234eb449c05e35eec37b3c::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 8, b"TEST", b"test", b"Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreibgbsqb546nspi3aqtvn774v3zjrdxcu3fy5yzzynk4m2mjieogwa?X-Algorithm=PINATA1&X-Date=1734628792&X-Expires=315360000&X-Method=GET&X-Signature=55ab9838df85b08de566b096c7ec04766392a19135c397e723308dc07fc77bff"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST>>(v2);
    }

    // decompiled from Move bytecode v6
}

