module 0xf4906d555081515bf23b360dd1a6e8431261d59375a719d56439d2df4af3e86d::df_and_dof {
    struct ScoreKey has copy, drop, store {
        dummy_field: bool,
    }

    struct HatKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ClothesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ShoesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Student has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct Score has store {
        math: u8,
        chinese: u8,
        english: u8,
    }

    struct Hat has store, key {
        id: 0x2::object::UID,
        brand: 0x1::string::String,
    }

    struct Clothes has store, key {
        id: 0x2::object::UID,
        brand: 0x1::string::String,
    }

    struct Shoes has store, key {
        id: 0x2::object::UID,
        brand: 0x1::string::String,
    }

    public fun new(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Student{
            id   : 0x2::object::new(arg1),
            name : arg0,
        };
        0x2::transfer::transfer<Student>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun score(arg0: &mut Student, arg1: u8, arg2: u8, arg3: u8) {
        let v0 = Score{
            math    : arg1,
            chinese : arg2,
            english : arg3,
        };
        let v1 = ScoreKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ScoreKey>(&arg0.id, v1)) {
            let v2 = ScoreKey{dummy_field: false};
            let Score {
                math    : _,
                chinese : _,
                english : _,
            } = 0x2::dynamic_field::remove<ScoreKey, Score>(&mut arg0.id, v2);
        };
        let v6 = ScoreKey{dummy_field: false};
        0x2::dynamic_field::add<ScoreKey, Score>(&mut arg0.id, v6, v0);
    }

    public fun wear_clothes(arg0: &mut Student, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Clothes{
            id    : 0x2::object::new(arg2),
            brand : arg1,
        };
        let v1 = ClothesKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<ClothesKey>(&arg0.id, v1)) {
            let v2 = ClothesKey{dummy_field: false};
            0x2::transfer::public_transfer<Clothes>(0x2::dynamic_object_field::remove<ClothesKey, Clothes>(&mut arg0.id, v2), 0x2::tx_context::sender(arg2));
        };
        let v3 = ClothesKey{dummy_field: false};
        0x2::dynamic_object_field::add<ClothesKey, Clothes>(&mut arg0.id, v3, v0);
    }

    public fun wear_hat(arg0: &mut Student, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Hat{
            id    : 0x2::object::new(arg2),
            brand : arg1,
        };
        let v1 = HatKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<HatKey>(&arg0.id, v1)) {
            let v2 = HatKey{dummy_field: false};
            0x2::transfer::public_transfer<Hat>(0x2::dynamic_field::remove<HatKey, Hat>(&mut arg0.id, v2), 0x2::tx_context::sender(arg2));
        };
        let v3 = HatKey{dummy_field: false};
        0x2::dynamic_field::add<HatKey, Hat>(&mut arg0.id, v3, v0);
    }

    public fun wear_shoes(arg0: &mut Student, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Shoes{
            id    : 0x2::object::new(arg2),
            brand : arg1,
        };
        let v1 = ShoesKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<ShoesKey>(&arg0.id, v1)) {
            let v2 = ShoesKey{dummy_field: false};
            0x2::transfer::public_transfer<Shoes>(0x2::dynamic_object_field::remove<ShoesKey, Shoes>(&mut arg0.id, v2), 0x2::tx_context::sender(arg2));
        };
        let v3 = ShoesKey{dummy_field: false};
        0x2::dynamic_object_field::add<ShoesKey, Shoes>(&mut arg0.id, v3, v0);
    }

    // decompiled from Move bytecode v6
}

