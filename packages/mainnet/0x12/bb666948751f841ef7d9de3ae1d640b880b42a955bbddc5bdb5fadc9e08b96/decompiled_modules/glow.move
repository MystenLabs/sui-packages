module 0x12bb666948751f841ef7d9de3ae1d640b880b42a955bbddc5bdb5fadc9e08b96::glow {
    struct GLOW has drop {
        dummy_field: bool,
    }

    struct ProtectedTreasury has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun total_supply(arg0: &ProtectedTreasury) : u64 {
        0x2::coin::total_supply<GLOW>(borrow_cap(arg0))
    }

    fun borrow_cap(arg0: &ProtectedTreasury) : &0x2::coin::TreasuryCap<GLOW> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<GLOW>>(&arg0.id, v0)
    }

    fun create_coin(arg0: GLOW, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (ProtectedTreasury, 0x2::coin::Coin<GLOW>) {
        let (v0, v1) = 0x2::coin::create_currency<GLOW>(arg0, 9, b"GLOW", b"GLOW", b"Currency of the Global Channel System", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgdmlld0JveD0iMCAwIDUxMiA1MTIiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxwYXRoIGQ9Ik0yNTYgNTEyQzM5Ny4zODUgNTEyIDUxMiAzOTcuMzg1IDUxMiAyNTZDNTEyIDExNC42MTUgMzk3LjM4NSAwIDI1NiAwQzExNC42MTUgMCAwIDExNC42MTUgMCAyNTZDMCAzOTcuMzg1IDExNC42MTUgNTEyIDI1NiA1MTJaIiBmaWxsPSIjRkUwMDAwIi8+CjxwYXRoIGQ9Ik00MDUuNDEyIDMzNy41NTZMMzM3LjI3NiA0MDUuNjkySDIxMS45NTZDMTM4Ljk1MiA0MDUuNjkyIDc4LjQyNDEgMzQ4LjIwNCA3OC40MjQxIDI3Ny45NEM3OC40MjQxIDI0My44NzIgOTIuNzIwMSAyMTIuODQ4IDExNS41MzIgMTg5LjcyOEwxODAuMDE2IDEyNS4yNDRDMjA0LjM0OCAxMDEuMjE2IDIzOS4wMjQgODUuNzA0IDI3Ni40MzYgODUuNzA0SDMyOC40NDhWMTQwLjQ1Nkg0MDUuNDA0VjMzNy41Nkw0MDUuNDEyIDMzNy41NTZaIiBmaWxsPSIjMTcxODE1Ii8+CjxwYXRoIGQ9Ik0xNDguOTkyIDIxMy40NTJDMTQ4Ljk5MiAxNDYuNTMyIDIwNi43ODQgOTEuNzg0MSAyNzYuNDQgOTEuNzg0MUgzMjIuMzcyVjE0Ni41MzZIMzk5LjMyOFYzMzUuMTI0SDI3Ni40NEMyMDYuNzg0IDMzNS4xMjQgMTQ4Ljk5MiAyODAuMzcyIDE0OC45OTIgMjEzLjQ1NlYyMTMuNDUyWiIgZmlsbD0iI0YwRTZCNCIvPgo8L3N2Zz4K")), arg2);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLOW>>(v1);
        let v3 = ProtectedTreasury{id: 0x2::object::new(arg2)};
        let v4 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<GLOW>>(&mut v3.id, v4, v2);
        (v3, 0x2::coin::mint<GLOW>(&mut v2, arg1, arg2))
    }

    fun init(arg0: GLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_coin(arg0, 10000000000000000000, arg1);
        0x2::transfer::share_object<ProtectedTreasury>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<GLOW>>(v1, @0x1a350ef298ce581e13139a6f255f40eb04041b15a3044942aea9537e11e435ec);
    }

    // decompiled from Move bytecode v6
}

