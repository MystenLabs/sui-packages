module 0x6038692db7009fd7f15b46817d86302b58ce2b313863ec7e1dd392dcbb95e40f::female {
    public(friend) fun select(arg0: u16) : 0x1::string::String {
        let v0 = arg0 % 34;
        let v1 = &v0;
        let v2 = if (*v1 == 0) {
            vector[b"Aela", b"Adi", b"Ahn", b"Ana", b"Andromeda", b"Annia", b"Andra", b"Apoch", b"Ai", b"Aimi"]
        } else if (*v1 == 1) {
            vector[b"Aries", b"Asta", b"Astra", b"Astria", b"Atsu", b"Ava", b"Avalon", b"Aurora", b"Aves", b"Aylo"]
        } else if (*v1 == 2) {
            vector[b"Ada", b"Addy", b"Ah Cy", b"Ah Kum", b"Ah Lam", b"Aiguo", b"Aki", b"Akiko", b"Akina", b"Akira"]
        } else if (*v1 == 3) {
            vector[b"Alexa", b"Alpha", b"Alva", b"Ami", b"Amaretto", b"Amaratsu", b"Amarterasu", b"Amaya", b"Amida", b"Amidala"]
        } else if (*v1 == 4) {
            vector[b"Amiga", b"Angel", b"Ani", b"An", b"Ann", b"Angela", b"Anita", b"Alita", b"Anna", b"Antikythera"]
        } else if (*v1 == 5) {
            vector[b"Apogee", b"Asa", b"Asami", b"Ava", b"Ayaka", b"Ayako", b"Aycee", b"Ayvee", b"Azerty", b"Bao"]
        } else if (*v1 == 6) {
            vector[b"Beep", b"Betty", b"Bet", b"Bit", b"Biyu", b"Biju", b"Blythe", b"Birdie", b"Bloom", b"Bunko"]
        } else if (*v1 == 7) {
            vector[b"Cam", b"Cameron", b"Candela", b"Capi", b"Cat", b"Calli", b"Calla", b"Calypso", b"Case", b"Cass"]
        } else if (*v1 == 8) {
            vector[b"Ceres", b"Clare", b"Catalina", b"Corona", b"Cleo", b"Clea", b"Cosmina", b"Cosmia", b"Cosima", b"Cathode"]
        } else if (*v1 == 9) {
            vector[b"Ceedee", b"Centra", b"Chassis", b"Chang", b"Changchang", b"Changying", b"Chika", b"Chikako", b"China", b"Chizo"]
        } else if (*v1 == 10) {
            vector[b"Chizu", b"Chyna", b"Cho", b"Chu", b"Chyu", b"Comma", b"Cookie", b"Cordy", b"Crystal", b"Cyberna"]
        } else if (*v1 == 11) {
            vector[b"Daisy", b"Daiyu", b"Deci", b"Deevee", b"Den", b"Delphine", b"Delphina", b"Dot", b"Dong", b"Dongmei"]
        } else if (*v1 == 12) {
            vector[b"Dyna", b"Eisa", b"Elsa", b"Ellio", b"Em", b"Ember", b"Emiko", b"Emily", b"Electra", b"Epoxy"]
        } else if (*v1 == 13) {
            vector[b"Eve", b"Evelyn", b"Exa", b"Fang", b"Fangtastic", b"Fangs", b"Frances", b"Farrah", b"Fawke", b"Falidae"]
        } else if (*v1 == 14) {
            vector[b"Freya", b"Freysa", b"Frost", b"Futura", b"Gamma", b"Gabriella", b"Gai", b"Gerty", b"Geri", b"Genesis"]
        } else if (*v1 == 15) {
            vector[b"Geneva", b"Genji", b"Gevie", b"Graze", b"Gielle", b"Golda", b"Grace", b"Halo", b"Hack", b"Hax"]
        } else if (*v1 == 16) {
            vector[b"Haven", b"Helvetica", b"Hinge", b"Hun", b"Hel", b"Hedy", b"Hong", b"Hua", b"Huilang", b"Ida"]
        } else if (*v1 == 17) {
            vector[b"Infinity", b"Io", b"Iris", b"Jan", b"Janet", b"Jago", b"Jay", b"Java", b"Juno", b"Jean"]
        } else if (*v1 == 18) {
            vector[b"Jeri", b"Jia", b"Jiao", b"Jinx", b"Joliet", b"Joi", b"Joy", b"Juan", b"Katusha", b"Kathleen"]
        } else if (*v1 == 19) {
            vector[b"Kay", b"Kate", b"Kala", b"Kale", b"Kai", b"Kibi", b"Kira", b"Kika", b"Kiyoko", b"Lan"]
        } else if (*v1 == 20) {
            vector[b"Lara", b"Laura", b"Larp", b"Legacy", b"Lela", b"Leeloo", b"Lexie", b"Luna", b"Lunar", b"Luv"]
        } else if (*v1 == 21) {
            vector[b"Lain", b"Libby", b"Lien", b"Lady", b"Lucia", b"Lux", b"Lilly", b"Lillix", b"Lin", b"Liu"]
        } else if (*v1 == 22) {
            vector[b"Laya", b"Loo", b"Loot", b"Lo", b"Lynx", b"Link", b"Ling", b"Lynn", b"Mae", b"Mai"]
        } else if (*v1 == 23) {
            vector[b"May", b"Marlyn", b"Magda", b"Media", b"Maria", b"Mariette", b"Melissa", b"Meta", b"Mica", b"Milli"]
        } else if (*v1 == 24) {
            vector[b"Mim", b"Molly", b"Maybelline", b"Moanna", b"Mosella", b"Moxie", b"Nikola", b"Nikki", b"Ning", b"Nui"]
        } else if (*v1 == 25) {
            vector[b"Neve", b"Nova", b"Noona", b"Nya", b"Nyx", b"Ori", b"Oria", b"Oriana", b"Organia", b"Orion"]
        } else if (*v1 == 26) {
            vector[b"Osson", b"Parity", b"Paradox", b"Parris", b"Pine", b"Pip", b"Pris", b"Prissy", b"Perigee", b"Perl"]
        } else if (*v1 == 27) {
            vector[b"Pixie", b"Plasma", b"Plink", b"Poly", b"Peach", b"Proxy", b"Qwerty", b"Queen", b"Radius", b"Raze"]
        } else if (*v1 == 28) {
            vector[b"Rexx", b"Roxxy", b"Ripley", b"Rina", b"Roberta", b"Radia", b"Rain", b"Refurb", b"Relay", b"Rosetta"]
        } else if (*v1 == 29) {
            vector[b"Rosie", b"Ruby", b"Rubi", b"Ruth", b"Rust", b"Samsung", b"Sata", b"Sara", b"Silica", b"Simula"]
        } else if (*v1 == 30) {
            vector[b"Shay", b"Shaylea", b"Sophie", b"Sony", b"Sprite", b"Star", b"Synergy", b"Tao", b"Taffi", b"Template"]
        } else if (*v1 == 31) {
            vector[b"Tera", b"Tetra", b"Tiff", b"Tilde", b"Ting", b"Toni", b"Trinity", b"Triniti", b"Trini", b"Trinny"]
        } else if (*v1 == 32) {
            vector[b"Uma", b"Una", b"Vasa", b"Veekay", b"Veronica", b"Vira", b"Willamette", b"Winifred", b"Yotta", b"Zetta"]
        } else {
            assert!(*v1 == 33, 13906834526530699263);
            vector[b"Zinc", b"Zhora"]
        };
        let v3 = v2;
        0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v3, (arg0 as u64) % 0x1::vector::length<vector<u8>>(&v3)))
    }

    // decompiled from Move bytecode v6
}

