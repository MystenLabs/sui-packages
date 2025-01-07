module 0x2ee85ec61775745b66bdc11039077c842db95a8cc736313a22fee6e5dc1798c1::beginner_village {
    struct BeginnerVillage has drop {
        dummy_field: bool,
    }

    fun err_name_not_all_letters_or_numbers() {
        abort 3
    }

    fun err_name_too_long() {
        abort 2
    }

    fun err_name_too_short() {
        abort 1
    }

    fun err_wrong_answer_one() {
        abort 4
    }

    fun err_wrong_answer_two() {
        abort 5
    }

    fun is_all_letters(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0;
        while (v1 < 0x1::string::length(arg0)) {
            if (!is_letter_or_number(*0x1::vector::borrow<u8>(v0, v1))) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    fun is_letter_or_number(arg0: u8) : bool {
        if (arg0 >= 65 && arg0 < 91) {
            true
        } else if (arg0 >= 97 && arg0 < 123) {
            true
        } else {
            arg0 >= 48 && arg0 < 58
        }
    }

    public fun pirate_kind() : u8 {
        0
    }

    public fun solve(arg0: &0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::KapyWorld, arg1: &mut 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew::KapyCrew, arg2: 0x1::string::String, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x1::string::length(&arg2) < 3) {
            err_name_too_short();
        };
        if (0x1::string::length(&arg2) > 16) {
            err_name_too_long();
        };
        if (!is_all_letters(&arg2)) {
            err_name_not_all_letters_or_numbers();
        };
        let v0 = (0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew::index(arg1) as u64);
        if (arg3 != (v0 * 618 + 3140) / v0) {
            err_wrong_answer_one();
        };
        if (arg4 != 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew::index(arg1) % 2 == 0) {
            err_wrong_answer_two();
        };
        0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew::update_name(arg1, arg2);
        let v1 = BeginnerVillage{dummy_field: false};
        0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew::recruit(arg1, 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_pirate::new<BeginnerVillage>(arg0, pirate_kind(), v1, arg5));
    }

    // decompiled from Move bytecode v6
}

