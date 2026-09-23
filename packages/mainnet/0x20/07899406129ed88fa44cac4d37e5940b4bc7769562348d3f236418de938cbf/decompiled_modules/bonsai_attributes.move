module 0x2007899406129ed88fa44cac4d37e5940b4bc7769562348d3f236418de938cbf::bonsai_attributes {
    fun common_face(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Joyful Grin")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Depressed")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Happy")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Joyful Grin")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Tongue Out")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Joyful Grin")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Angry")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Tongue Out")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Tongue Out")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Happy")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Depressed")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Sleepy")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Sleepy")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Teary")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Grumpy")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Depressed")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Chubby")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Surprised")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"Grumpy")
        } else if (arg0 == 19) {
            0x1::string::utf8(b"Sleepy")
        } else if (arg0 == 20) {
            0x1::string::utf8(b"Teary")
        } else if (arg0 == 21) {
            0x1::string::utf8(b"Joyful Grin")
        } else if (arg0 == 22) {
            0x1::string::utf8(b"Teary")
        } else if (arg0 == 23) {
            0x1::string::utf8(b"Teary")
        } else if (arg0 == 24) {
            0x1::string::utf8(b"Tongue Out")
        } else if (arg0 == 25) {
            0x1::string::utf8(b"Chubby")
        } else if (arg0 == 26) {
            0x1::string::utf8(b"Fuming")
        } else if (arg0 == 27) {
            0x1::string::utf8(b"Fuming")
        } else if (arg0 == 28) {
            0x1::string::utf8(b"Tongue Out")
        } else if (arg0 == 29) {
            0x1::string::utf8(b"Tongue Out")
        } else if (arg0 == 30) {
            0x1::string::utf8(b"Neutral")
        } else if (arg0 == 31) {
            0x1::string::utf8(b"Angry")
        } else if (arg0 == 32) {
            0x1::string::utf8(b"Joyful Grin")
        } else if (arg0 == 33) {
            0x1::string::utf8(b"Tongue Out")
        } else if (arg0 == 34) {
            0x1::string::utf8(b"Sleepy")
        } else if (arg0 == 35) {
            0x1::string::utf8(b"Grumpy")
        } else if (arg0 == 36) {
            0x1::string::utf8(b"Grumpy")
        } else if (arg0 == 37) {
            0x1::string::utf8(b"Happy")
        } else if (arg0 == 38) {
            0x1::string::utf8(b"Grumpy")
        } else if (arg0 == 39) {
            0x1::string::utf8(b"Neutral")
        } else if (arg0 == 40) {
            0x1::string::utf8(b"Tongue Out")
        } else if (arg0 == 41) {
            0x1::string::utf8(b"Teary")
        } else if (arg0 == 42) {
            0x1::string::utf8(b"Fuming")
        } else if (arg0 == 43) {
            0x1::string::utf8(b"Angry")
        } else if (arg0 == 44) {
            0x1::string::utf8(b"Neutral")
        } else {
            0x1::string::utf8(b"Joyful Grin")
        }
    }

    fun common_feet(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 19) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 20) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 21) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 22) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 23) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 24) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 25) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 26) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 27) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 28) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 29) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 30) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 31) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 32) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 33) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 34) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 35) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 36) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 37) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 38) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 39) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 40) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 41) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 42) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 43) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 44) {
            0x1::string::utf8(b"Bare Roots")
        } else {
            0x1::string::utf8(b"Traditional Geta")
        }
    }

    fun common_pot(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 19) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 20) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 21) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 22) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 23) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 24) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 25) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 26) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 27) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 28) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 29) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 30) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 31) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 32) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 33) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 34) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 35) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 36) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 37) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 38) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 39) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 40) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 41) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 42) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 43) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 44) {
            0x1::string::utf8(b"Indigo Round")
        } else {
            0x1::string::utf8(b"Natural Rock")
        }
    }

    fun common_tree(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Rose")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Cherry Blossom")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Cherry Blossom")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Bamboo")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Bonsai Pine")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Bamboo")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Classic Pine")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Classic Pine")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Bonsai Pine")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Bamboo")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Rose")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Rose")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Bonsai Pine")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Rose")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Bamboo")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Cherry Blossom")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Bonsai Pine")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Rose")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"Bamboo")
        } else if (arg0 == 19) {
            0x1::string::utf8(b"Pachira")
        } else if (arg0 == 20) {
            0x1::string::utf8(b"Bamboo")
        } else if (arg0 == 21) {
            0x1::string::utf8(b"Pachira")
        } else if (arg0 == 22) {
            0x1::string::utf8(b"Bonsai Pine")
        } else if (arg0 == 23) {
            0x1::string::utf8(b"Rose")
        } else if (arg0 == 24) {
            0x1::string::utf8(b"Classic Pine")
        } else if (arg0 == 25) {
            0x1::string::utf8(b"Pachira")
        } else if (arg0 == 26) {
            0x1::string::utf8(b"Cherry Blossom")
        } else if (arg0 == 27) {
            0x1::string::utf8(b"Classic Pine")
        } else if (arg0 == 28) {
            0x1::string::utf8(b"Cherry Blossom")
        } else if (arg0 == 29) {
            0x1::string::utf8(b"Rose")
        } else if (arg0 == 30) {
            0x1::string::utf8(b"Classic Pine")
        } else if (arg0 == 31) {
            0x1::string::utf8(b"Pachira")
        } else if (arg0 == 32) {
            0x1::string::utf8(b"Pachira")
        } else if (arg0 == 33) {
            0x1::string::utf8(b"Bonsai Pine")
        } else if (arg0 == 34) {
            0x1::string::utf8(b"Bamboo")
        } else if (arg0 == 35) {
            0x1::string::utf8(b"Classic Pine")
        } else if (arg0 == 36) {
            0x1::string::utf8(b"Pachira")
        } else if (arg0 == 37) {
            0x1::string::utf8(b"Classic Pine")
        } else if (arg0 == 38) {
            0x1::string::utf8(b"Bamboo")
        } else if (arg0 == 39) {
            0x1::string::utf8(b"Rose")
        } else if (arg0 == 40) {
            0x1::string::utf8(b"Classic Pine")
        } else if (arg0 == 41) {
            0x1::string::utf8(b"Bonsai Pine")
        } else if (arg0 == 42) {
            0x1::string::utf8(b"Bamboo")
        } else if (arg0 == 43) {
            0x1::string::utf8(b"Bonsai Pine")
        } else if (arg0 == 44) {
            0x1::string::utf8(b"Cherry Blossom")
        } else {
            0x1::string::utf8(b"Rose")
        }
    }

    public(friend) fun face_of(arg0: u8, arg1: u64) : 0x1::string::String {
        if (arg0 == 1) {
            uncommon_face(arg1)
        } else if (arg0 == 2) {
            rare_face(arg1)
        } else if (arg0 == 3) {
            legendary_face(arg1)
        } else if (arg0 == 4) {
            genesis_face(arg1)
        } else {
            common_face(arg1)
        }
    }

    public(friend) fun feet_of(arg0: u8, arg1: u64) : 0x1::string::String {
        if (arg0 == 1) {
            uncommon_feet(arg1)
        } else if (arg0 == 2) {
            rare_feet(arg1)
        } else if (arg0 == 3) {
            legendary_feet(arg1)
        } else if (arg0 == 4) {
            genesis_feet(arg1)
        } else {
            common_feet(arg1)
        }
    }

    fun genesis_face(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Nirvana")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Zen")
        } else {
            0x1::string::utf8(b"Nirvana")
        }
    }

    fun genesis_feet(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Gold Geta")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Gold Geta")
        } else {
            0x1::string::utf8(b"Gold Geta")
        }
    }

    fun genesis_pot(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Gold Square")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Gold Round")
        } else {
            0x1::string::utf8(b"Gold Square")
        }
    }

    fun genesis_tree(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Gold Pine")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Gold Bamboo")
        } else {
            0x1::string::utf8(b"Gold Pine")
        }
    }

    fun legendary_face(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Nirvana")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Furious")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Zen")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Shocked")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Joyful Grin")
        } else {
            0x1::string::utf8(b"Nirvana")
        }
    }

    fun legendary_feet(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Gold Kicks")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Gold Kicks")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Gold Kicks")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Gold Roots")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Gold Roots")
        } else {
            0x1::string::utf8(b"Gold Kicks")
        }
    }

    fun legendary_pot(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Porcelain Rock")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Porcelain Rock")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Porcelain Rock")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Black Rock")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Black Rock")
        } else {
            0x1::string::utf8(b"Porcelain Rock")
        }
    }

    fun legendary_tree(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Gorilla")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Sui Stone")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Neon Cyber Tree")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Psychedelic Mushroom")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Psychedelic Cactus")
        } else {
            0x1::string::utf8(b"Gorilla")
        }
    }

    public(friend) fun pot_of(arg0: u8, arg1: u64) : 0x1::string::String {
        if (arg0 == 1) {
            uncommon_pot(arg1)
        } else if (arg0 == 2) {
            rare_pot(arg1)
        } else if (arg0 == 3) {
            legendary_pot(arg1)
        } else if (arg0 == 4) {
            genesis_pot(arg1)
        } else {
            common_pot(arg1)
        }
    }

    fun rare_face(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Zen")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Furious")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Chubby")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Shocked")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Nirvana")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Teary")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Chubby")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Chubby")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Nirvana")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Nirvana")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Angry")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Surprised")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Grumpy")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Shocked")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Neutral")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Happy")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Depressed")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Depressed")
        } else {
            0x1::string::utf8(b"Zen")
        }
    }

    fun rare_feet(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Canvas Sneakers")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Canvas Sneakers")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Canvas Sneakers")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Canvas Sneakers")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Canvas Sneakers")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Canvas Sneakers")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Canvas Sneakers")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Canvas Sneakers")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Canvas Sneakers")
        } else {
            0x1::string::utf8(b"Brown Boots")
        }
    }

    fun rare_pot(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Jade Rock")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Jade Rock")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Brown Square")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Brown Square")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Jade Rock")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Brown Square")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Cyan Square")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Cyan Square")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Brown Square")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Jade Round")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Cyan Square")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Jade Round")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Cyan Square")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Jade Round")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Jade Rock")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Jade Round")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Jade Rock")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Jade Round")
        } else {
            0x1::string::utf8(b"Jade Rock")
        }
    }

    fun rare_tree(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Cactus")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Weeping Cherry")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Cyber Tree")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Herb")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Cactus")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Cactus")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Venus Flytrap")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Cyber Tree")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Herb")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Cyber Tree")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Cyber Tree")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Mushroom")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Herb")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Herb")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Weeping Cherry")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Mushroom")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Weeping Cherry")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Venus Flytrap")
        } else {
            0x1::string::utf8(b"Cactus")
        }
    }

    public(friend) fun rarity_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"Uncommon")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Rare")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Legendary")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Genesis")
        } else {
            0x1::string::utf8(b"Common")
        }
    }

    public(friend) fun tree_of(arg0: u8, arg1: u64) : 0x1::string::String {
        if (arg0 == 1) {
            uncommon_tree(arg1)
        } else if (arg0 == 2) {
            rare_tree(arg1)
        } else if (arg0 == 3) {
            legendary_tree(arg1)
        } else if (arg0 == 4) {
            genesis_tree(arg1)
        } else {
            common_tree(arg1)
        }
    }

    fun uncommon_face(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Chubby")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Grumpy")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Grumpy")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Neutral")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Depressed")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Tongue Out")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Surprised")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Depressed")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Surprised")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Happy")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Sleepy")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Tongue Out")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Angry")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Neutral")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Tongue Out")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Chubby")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Teary")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Chubby")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"Joyful Grin")
        } else if (arg0 == 19) {
            0x1::string::utf8(b"Surprised")
        } else if (arg0 == 20) {
            0x1::string::utf8(b"Grumpy")
        } else if (arg0 == 21) {
            0x1::string::utf8(b"Neutral")
        } else if (arg0 == 22) {
            0x1::string::utf8(b"Teary")
        } else if (arg0 == 23) {
            0x1::string::utf8(b"Teary")
        } else if (arg0 == 24) {
            0x1::string::utf8(b"Teary")
        } else if (arg0 == 25) {
            0x1::string::utf8(b"Tongue Out")
        } else if (arg0 == 26) {
            0x1::string::utf8(b"Teary")
        } else if (arg0 == 27) {
            0x1::string::utf8(b"Fuming")
        } else if (arg0 == 28) {
            0x1::string::utf8(b"Depressed")
        } else if (arg0 == 29) {
            0x1::string::utf8(b"Tongue Out")
        } else {
            0x1::string::utf8(b"Chubby")
        }
    }

    fun uncommon_feet(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Canvas Sneakers")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Canvas Sneakers")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Canvas Sneakers")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 19) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 20) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 21) {
            0x1::string::utf8(b"Canvas Sneakers")
        } else if (arg0 == 22) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 23) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 24) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 25) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 26) {
            0x1::string::utf8(b"Brown Boots")
        } else if (arg0 == 27) {
            0x1::string::utf8(b"Bare Roots")
        } else if (arg0 == 28) {
            0x1::string::utf8(b"Traditional Geta")
        } else if (arg0 == 29) {
            0x1::string::utf8(b"Brown Boots")
        } else {
            0x1::string::utf8(b"Brown Boots")
        }
    }

    fun uncommon_pot(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Jade Round")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Cyan Square")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Cyan Square")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Brown Square")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Jade Rock")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Brown Square")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Brown Square")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Jade Round")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Jade Rock")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Jade Rock")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Cyan Square")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Indigo Round")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Jade Rock")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Cyan Square")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 19) {
            0x1::string::utf8(b"Jade Round")
        } else if (arg0 == 20) {
            0x1::string::utf8(b"Brown Square")
        } else if (arg0 == 21) {
            0x1::string::utf8(b"Jade Rock")
        } else if (arg0 == 22) {
            0x1::string::utf8(b"Jade Round")
        } else if (arg0 == 23) {
            0x1::string::utf8(b"Jade Round")
        } else if (arg0 == 24) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 25) {
            0x1::string::utf8(b"Jade Round")
        } else if (arg0 == 26) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 27) {
            0x1::string::utf8(b"Red Square")
        } else if (arg0 == 28) {
            0x1::string::utf8(b"Natural Rock")
        } else if (arg0 == 29) {
            0x1::string::utf8(b"Natural Rock")
        } else {
            0x1::string::utf8(b"Indigo Round")
        }
    }

    fun uncommon_tree(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Monstera")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Azalea")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Sansevieria")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Sansevieria")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Camellia")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Azalea")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Sansevieria")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Sansevieria")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Monstera")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Sansevieria")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Camellia")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Monstera")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Maple")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Sansevieria")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Cedar")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Azalea")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Azalea")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Monstera")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"Maple")
        } else if (arg0 == 19) {
            0x1::string::utf8(b"Cedar")
        } else if (arg0 == 20) {
            0x1::string::utf8(b"Cedar")
        } else if (arg0 == 21) {
            0x1::string::utf8(b"Monstera")
        } else if (arg0 == 22) {
            0x1::string::utf8(b"Azalea")
        } else if (arg0 == 23) {
            0x1::string::utf8(b"Maple")
        } else if (arg0 == 24) {
            0x1::string::utf8(b"Cedar")
        } else if (arg0 == 25) {
            0x1::string::utf8(b"Maple")
        } else if (arg0 == 26) {
            0x1::string::utf8(b"Monstera")
        } else if (arg0 == 27) {
            0x1::string::utf8(b"Cedar")
        } else if (arg0 == 28) {
            0x1::string::utf8(b"Monstera")
        } else if (arg0 == 29) {
            0x1::string::utf8(b"Monstera")
        } else {
            0x1::string::utf8(b"Monstera")
        }
    }

    // decompiled from Move bytecode v7
}

