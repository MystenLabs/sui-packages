module 0xfb89b5303b8bc7a4033260db47448e6421cb91ff7a0a9389e2fc1b3b3c564344::constants {
    public fun get_character_name(arg0: u64) : vector<u8> {
        if (arg0 == 1) {
            b"Goblin"
        } else if (arg0 == 2) {
            b"Orc"
        } else if (arg0 == 3) {
            b"Knight"
        } else if (arg0 == 4) {
            b"Elf Archer"
        } else if (arg0 == 5) {
            b"Minotaur"
        } else if (arg0 == 6) {
            b"Sorcerer"
        } else if (arg0 == 7) {
            b"Necromancer"
        } else if (arg0 == 8) {
            b"Dragon"
        } else {
            b""
        }
    }

    public fun get_lock_duration(arg0: u64) : u64 {
        if (arg0 >= 1 && arg0 <= 8) {
            1 * 2629746000
        } else if (arg0 >= 9 && arg0 <= 16) {
            2 * 2629746000
        } else if (arg0 >= 17 && arg0 <= 24) {
            3 * 2629746000
        } else if (arg0 >= 25 && arg0 <= 32) {
            4 * 2629746000
        } else if (arg0 >= 33 && arg0 <= 40) {
            5 * 2629746000
        } else if (arg0 >= 41 && arg0 <= 48) {
            6 * 2629746000
        } else if (arg0 >= 49 && arg0 <= 56) {
            7 * 2629746000
        } else if (arg0 >= 57 && arg0 <= 64) {
            8 * 2629746000
        } else {
            0
        }
    }

    public fun get_nft_image(arg0: u64) : vector<u8> {
        if (arg0 == 1) {
            b"1"
        } else if (arg0 == 2) {
            b"2"
        } else if (arg0 == 3) {
            b"3"
        } else if (arg0 == 4) {
            b"4"
        } else if (arg0 == 5) {
            b"5"
        } else if (arg0 == 6) {
            b"6"
        } else if (arg0 == 7) {
            b"7"
        } else if (arg0 == 8) {
            b"8"
        } else if (arg0 == 9) {
            b"9"
        } else if (arg0 == 10) {
            b"10"
        } else if (arg0 == 11) {
            b"11"
        } else if (arg0 == 12) {
            b"12"
        } else if (arg0 == 13) {
            b"13"
        } else if (arg0 == 14) {
            b"14"
        } else if (arg0 == 15) {
            b"15"
        } else if (arg0 == 16) {
            b"16"
        } else if (arg0 == 17) {
            b"17"
        } else if (arg0 == 18) {
            b"18"
        } else if (arg0 == 19) {
            b"19"
        } else if (arg0 == 20) {
            b"20"
        } else if (arg0 == 21) {
            b"21"
        } else if (arg0 == 22) {
            b"22"
        } else if (arg0 == 23) {
            b"23"
        } else if (arg0 == 24) {
            b"24"
        } else if (arg0 == 25) {
            b"25"
        } else if (arg0 == 26) {
            b"26"
        } else if (arg0 == 27) {
            b"27"
        } else if (arg0 == 28) {
            b"28"
        } else if (arg0 == 29) {
            b"29"
        } else if (arg0 == 30) {
            b"30"
        } else if (arg0 == 31) {
            b"31"
        } else if (arg0 == 32) {
            b"32"
        } else if (arg0 == 33) {
            b"33"
        } else if (arg0 == 34) {
            b"34"
        } else if (arg0 == 35) {
            b"35"
        } else if (arg0 == 36) {
            b"36"
        } else if (arg0 == 37) {
            b"37"
        } else if (arg0 == 38) {
            b"38"
        } else if (arg0 == 39) {
            b"39"
        } else if (arg0 == 40) {
            b"40"
        } else if (arg0 == 41) {
            b"41"
        } else if (arg0 == 42) {
            b"42"
        } else if (arg0 == 43) {
            b"43"
        } else if (arg0 == 44) {
            b"44"
        } else if (arg0 == 45) {
            b"45"
        } else if (arg0 == 46) {
            b"46"
        } else if (arg0 == 47) {
            b"47"
        } else if (arg0 == 48) {
            b"48"
        } else if (arg0 == 49) {
            b"49"
        } else if (arg0 == 50) {
            b"50"
        } else if (arg0 == 51) {
            b"51"
        } else if (arg0 == 52) {
            b"52"
        } else if (arg0 == 53) {
            b"53"
        } else if (arg0 == 54) {
            b"54"
        } else if (arg0 == 55) {
            b"55"
        } else if (arg0 == 56) {
            b"56"
        } else if (arg0 == 57) {
            b"57"
        } else if (arg0 == 58) {
            b"58"
        } else if (arg0 == 59) {
            b"59"
        } else if (arg0 == 60) {
            b"60"
        } else if (arg0 == 61) {
            b"61"
        } else if (arg0 == 62) {
            b"62"
        } else if (arg0 == 63) {
            b"63"
        } else if (arg0 == 64) {
            b"64"
        } else {
            b""
        }
    }

    // decompiled from Move bytecode v6
}

