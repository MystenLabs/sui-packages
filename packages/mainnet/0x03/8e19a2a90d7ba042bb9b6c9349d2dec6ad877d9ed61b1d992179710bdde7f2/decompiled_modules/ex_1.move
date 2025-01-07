module 0x38e19a2a90d7ba042bb9b6c9349d2dec6ad877d9ed61b1d992179710bdde7f2::ex_1 {
    struct SuiMoverExercise1 has drop {
        dummy_field: bool,
    }

    fun err_username_not_all_letters_or_numbers() {
        abort 3
    }

    fun err_username_too_long() {
        abort 2
    }

    fun err_username_too_short() {
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
        arg0 >= 65 && arg0 < 91 || arg0 >= 97 && arg0 < 123 || arg0 >= 48 && arg0 < 58
    }

    public fun solve(arg0: &0x38e19a2a90d7ba042bb9b6c9349d2dec6ad877d9ed61b1d992179710bdde7f2::config::Config, arg1: &mut 0x38e19a2a90d7ba042bb9b6c9349d2dec6ad877d9ed61b1d992179710bdde7f2::kapy::Kapy, arg2: 0x1::string::String, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x1::string::length(&arg2) < 3) {
            err_username_too_short();
        };
        if (0x1::string::length(&arg2) > 16) {
            err_username_too_long();
        };
        if (!is_all_letters(&arg2)) {
            err_username_not_all_letters_or_numbers();
        };
        let v0 = (0x38e19a2a90d7ba042bb9b6c9349d2dec6ad877d9ed61b1d992179710bdde7f2::kapy::index(arg1) as u64);
        if (arg3 != (v0 * 618 + 3140) / v0) {
            err_wrong_answer_one();
        };
        if (arg4 != 0x38e19a2a90d7ba042bb9b6c9349d2dec6ad877d9ed61b1d992179710bdde7f2::kapy::index(arg1) % 2 == 0) {
            err_wrong_answer_two();
        };
        0x38e19a2a90d7ba042bb9b6c9349d2dec6ad877d9ed61b1d992179710bdde7f2::kapy::update_username(arg1, arg2);
        let v1 = SuiMoverExercise1{dummy_field: false};
        0x38e19a2a90d7ba042bb9b6c9349d2dec6ad877d9ed61b1d992179710bdde7f2::kapy::carry(arg1, 0x38e19a2a90d7ba042bb9b6c9349d2dec6ad877d9ed61b1d992179710bdde7f2::orange::mint<SuiMoverExercise1>(arg0, 1, v1, arg5));
    }

    // decompiled from Move bytecode v6
}

